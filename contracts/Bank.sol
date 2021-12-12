// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Bank {
    mapping(address => uint256) accountBalances;
    address[] accepted_addresses;
    address payable owner;

    constructor(address[] memory games_addresses) {
        accepted_addresses = games_addresses;
        owner = payable(msg.sender);
        accountBalances[owner] = 0;
    }

    function getBalance(address _address) public view returns (uint256) {
        return accountBalances[_address];
    }

    function isReserveEnough(uint256 potentialReturns) public view returns (bool) {
        return accountBalances[owner] > potentialReturns;
    }

    function isPlayerSolvent(address _address, uint256 betAmount) public view returns (bool) {
        return accountBalances[_address] >= betAmount;
    }

    function deposit() external payable {
        accountBalances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amountToTransfer = accountBalances[msg.sender];

        accountBalances[msg.sender] = 0;

        payable(msg.sender).transfer(amountToTransfer);
    }

    //we can only transact to and from the owner's account.
    //the owner's account act as the bank's reserve 
    function toOwner(address _from, uint256 amount) public {
        moveFunds(_from, owner, amount);
    }

    function fromOwner(address _to, uint256 amount) public {
        moveFunds(owner, _to, amount);
    }

    function moveFunds(
        address _from,
        address _to,
        uint256 amount
    ) internal {
        //verify that the sender is an authorized game
        bool isAddressValid = false;
        for (uint256 i = 0; i < accepted_addresses.length; i++) {
            if (msg.sender == accepted_addresses[i]) {
                isAddressValid = true;
                break;
            }
        }
        require(
            isAddressValid,
            "Sender's address is not recognized by the bank."
        );
        //move the funds
        accountBalances[_from] -= amount;
        accountBalances[_to] += amount;
    }
}

