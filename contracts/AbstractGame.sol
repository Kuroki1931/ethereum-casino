// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./Mortal.sol";
import "./Bank.sol";

abstract contract AbstractGame is Mortal {
    uint256 betAmount;
    uint256 randNonce;
    Bank bankAccount;

    constructor() {
        betAmount = 0;
        randNonce = 0;
    }

    function setBankAddress(address bankAddress) public {
        require(msg.sender == owner, "only the owner can change the bank address!");
        bankAccount = Bank(bankAddress);
    }

    //generate a pseudo-random number between 0 and (max-1)
    function rand(uint256 max) public returns (uint256) {
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % max;
        randNonce++;
        return random;
    }

    function preChecks(uint256 potentialReturns) internal view {
        require(
            bankAccount.isPlayerSolvent(msg.sender, betAmount),
            "Player doesn't have enough funds to do that bet. Try again with a smaller bet!"
        );
        require (
            bankAccount.isReserveEnough(potentialReturns),
            "Bank reserve doesn't have enough funds to pay a winning player. Try again with a smaller bet!"
        );
    }

    function play() internal virtual;
}
