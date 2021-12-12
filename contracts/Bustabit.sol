// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./AbstractGame.sol";
import "./Bank.sol";

contract Bustabit is AbstractGame {
    uint256 userGuess;
    constructor() {}

    function bet(uint256 amount, uint256 _userGuess) public {
        betAmount = amount;
        userGuess = _userGuess;
        preChecks(calculatePaybackAmount());
        bankAccount.toOwner(msg.sender, betAmount);
        play();
    }

    function play() internal override {
        uint256 multiplier = rand(13);
        if (multiplier <= 3) {
            multiplier = 0;
        }
        else {
            multiplier -= 3;
        }
        if (userGuess <= multiplier) {
            uint256 amountWon = (betAmount * userGuess) / 2;
            bankAccount.fromOwner(msg.sender, amountWon);
        }
    }

    function calculatePaybackAmount() internal view returns (uint256) {
        return (betAmount * userGuess) / 2;
    }
}
