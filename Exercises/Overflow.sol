// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract TestOverflow {
    function addOne(uint8 a) public pure returns(uint8) {
        require(a + 1 > a, "sorry, a is too big");
        return a + 1;
    }
}