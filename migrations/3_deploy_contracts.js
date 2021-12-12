var Mortal = artifacts.require("Mortal");
// var AbstractGame = artifacts.require("AbstractGame");

module.exports = function(deployer) {
	deployer.deploy(Mortal);
  	// deployer.deploy(AbstractGame);
};
