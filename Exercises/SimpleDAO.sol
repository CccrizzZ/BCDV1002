// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

contract SimpleDAO {
    // map of account address and deposited balance in wei
    mapping(address => uint) public balance;

    // deposite to this DAO contract
    function deposit() public payable {
        // that sender address gains the value sent
        balance[msg.sender] += msg.value;
    }

    // withdraw function
    function withdraw(uint amount) public {
        // prevent withdraw if no enough balance in the matching account slot in this DAO
        require(balance[msg.sender] >= amount, "not enough balance");
        
        // send input amount of eth to the caller's account
        msg.sender.call.value(amount)("");
        
        // subtract balance from the record of this contract
        balance[msg.sender] -= amount;
    }
}