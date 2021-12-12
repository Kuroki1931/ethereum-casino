App = {
  web3Provider: null,
  contracts: {},

  init: async function() {

    return await App.initWeb3();
  },

  initWeb3: async function() {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.request({ method: "eth_requestAccounts" });;
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Bank.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with @truffle/contract
      const BankArtifact = data;
      App.contracts.Bank = TruffleContract(BankArtifact);

      // Set the provider for our contract
      App.contracts.Bank.setProvider(App.web3Provider);

      // Use our contract
      return App.setBalance();
    });
    $.getJSON('Slot.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with @truffle/contract
      const SlotArtifact = data;
      App.contracts.Slot = TruffleContract(SlotArtifact);

      // Set the provider for our contract
      App.contracts.Slot.setProvider(App.web3Provider);
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-bet', App.bet);
  },

  bet: function() {
    const form = $('form').serializeArray()
    const address = form[0]
    const amount = form[1]

    App.contracts.Slot.deployed().then((instance) => {
      slotInstance = instance

      return slotInstance.bet.call(amount, { from: address, value: amount })
    })
  },

  setBalance: function() {
    var bankInstance;
    const bankAddress = "0x260ea4f7dbf7cb2684635896e242b3fa4eec8840"


    App.contracts.Bank.deployed().then(function(instance) {
      bankInstance = instance;

      return bankInstance.getBalance.call(bankAddress);
    }).then(function(balance) {
      document.getElementById("bank-balance").innerHTML = balance.toString();
      document.getElementById("bank-address").innerHTML = bankInstance.address;
    }).catch(function(err) {
      console.log(err.message);
    });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
