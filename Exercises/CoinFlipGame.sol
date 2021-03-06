// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract CoinFlipGame {
  
  address owner;

  // payable contructor means that the deployer should deposite some ether when deploying
  constructor() payable {
    owner = msg.sender;
  }
  
  // win and lose event
  event LogWin(uint256 amount);
  event LogLose(uint256 amount);
  

  // bet function requires deposite from deployer 
  function bet() public payable {
    
    // if bet is bigger than 1/10th of the contract balance 
    // reject and throw msg "bet size too big"
    require(msg.value >= maxBet(), "bet size too big");
    


    // run the generateRandomBit function to determine win or lose
    if (generateRandomBit()) {
      // emit win state
      emit LogWin(msg.value);

      // send the deployer double the contract amount
      payable(msg.sender).transfer(msg.value * 2);

    } else {
      // emit lose state
      emit LogLose(msg.value);

    }
  }
  

  // max bet getter function return 1/10th of this contract's balance
  function maxBet() public view returns(uint256) {
    return address(this).balance / 10;
  }
  

  function getContractBalance()public view returns(uint256) {
    return address(this).balance;
  }
  
  
  function getOwnerAddress()public view returns(address) {
    return owner;
  }


  // this function is problematic
  // The generateRandomBit() function uses several of the solidity
  // special variables, and combines them with the hash function keccak256().
  // returns true or false randomly
  function generateRandomBit() private view returns(bool) {
    bytes32 hash = keccak256(
      abi.encodePacked(
        msg.sender,
        msg.value,
        block.number,
        block.timestamp,
        gasleft()
      )
    );
                  
    return uint256(hash) % 2 == 0;
  }
}