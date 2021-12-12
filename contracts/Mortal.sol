// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Mortal {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }
}
