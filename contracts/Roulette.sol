// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./AbstractGame.sol";
import "./Bank.sol";

contract Roulette is AbstractGame {
    uint256[] userBets;
    uint256 roll;
    uint256 numberOfChoices = 37;

    constructor() {}

    function bet(uint256[] calldata _numbers, uint256 _amount)
        public
        returns (uint256)
    {
        userBets = _numbers;
        betAmount = _amount;
        preChecks(calculatePaybackAmount());

        bankAccount.toOwner(msg.sender, betAmount);
        play();
        return roll;
    }

    function play() internal override {
        roll = rand(numberOfChoices);
        uint256 paybackAmount = calculatePaybackAmount();
        for (uint256 i = 0; i < userBets.length; i++) {
            if (roll == userBets[i]) {
                bankAccount.fromOwner(msg.sender, paybackAmount);
                break;
            }
        }
    }

    function calculatePaybackAmount() internal view returns(uint256) {
        return (betAmount * (numberOfChoices - 1)) / userBets.length;
    }
}
