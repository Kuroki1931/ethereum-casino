var Slot = artifacts.require("Slot");
var Roulette = artifacts.require("Roulette");
var Bustabit = artifacts.require("Bustabit");

module.exports = function(deployer) {
	deployer.deploy(Slot);
  	deployer.deploy(Roulette);
	deployer.deploy(Bustabit);
};
