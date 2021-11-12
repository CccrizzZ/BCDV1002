// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ConditionalTipper {
    constructor(address payable tipjar, uint256 limit) payable {
        if (tipjar.balance < limit) {
            tipjar.transfer(limit - tipjar.balance);
        }

        selfdestruct(payable(msg.sender));
    }
}