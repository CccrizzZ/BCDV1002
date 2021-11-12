// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract TipJar{
    
    // owner address
    address owner;
    
    
    // payable constructor
    constructor() payable{
        // set owner of the contract to who ever deployed this contract
        owner = address(msg.sender);
    }
    
    
    // onlyOwner custom function modifier 
    modifier onlyOwner() {
        // require the caller address to be the same as deployer(owner)
        require(msg.sender == owner, 'only owner can call this function');
        _;
    }
    
    
    // get contract balance in ether
    function getContractBalance() public view returns(uint256){
        return address(this).balance;
    }
 
    
    // get owner address
    function getOwen() public view returns(address){
        return owner;
    }
    


    // set owner
    function setOwner(address newOwner) public onlyOwner {
        
        // transfer ownership
        owner = newOwner;
    }
    
    
    // withdraw function owner only 
    function withdraw()public onlyOwner {
        
        // transfer all balance to the owner
        payable(owner).transfer(address(this).balance);
    }
    
    
    // receive function
    receive() external payable{}
    
    // fallback function
    fallback() external payable {}
    
}