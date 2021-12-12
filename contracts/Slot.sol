// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./AbstractGame.sol";
import "./Bank.sol";

contract Slot is AbstractGame {
    address gameOwner;

    constructor() {}

    function bet(uint256 amount) public {
        betAmount = amount;
        preChecks(calculatePaybackAmount(777));
        bankAccount.toOwner(msg.sender, betAmount);
        play();
    }

    function play() internal override {
        uint256 slotNumber = rand(1000);
        uint256 paybackAmount = calculatePaybackAmount(slotNumber);
        bankAccount.fromOwner(msg.sender, paybackAmount);
    }

    function rate(uint256 _slotNumber) internal pure returns (uint256){
        // sum expected return is 0.511
        if(_slotNumber == 111){
            return 1;
        } else if(_slotNumber == 222) {
            return 2;
        } else if(_slotNumber == 333) {
            return 4;
        } else if(_slotNumber == 444) {
            return 8;
        } else if(_slotNumber == 555) {
            return 16;
        } else if(_slotNumber == 666) {
            return 32;
        } else if(_slotNumber == 888) {
            return 64;
        } else if(_slotNumber == 999) {
            return 128;
        } else if(_slotNumber == 777) {
            return 256;
        } else {
            return 0;
        }
    }

    function calculatePaybackAmount(uint256 _slotNumber) internal view returns (uint256) {
        return betAmount * rate(_slotNumber);
    }
}