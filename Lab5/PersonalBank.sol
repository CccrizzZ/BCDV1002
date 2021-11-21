pragma solidity ^0.5.0;

contract PersonalBank {
    // maximum amount of withdraw
    uint constant maxCheck = 1;

    // owner of bank account (this contract)
    address owner;

    // map for all the hashes used
    mapping(bytes32 => uint)  ;
    
    constructor() public payable {
        // set owner on construct
        owner = msg.sender;
    }
    

    // withdraw check function
    function cashCheque(address payable to, uint256 amount, bytes32 r, bytes32 s, uint8 v, bytes32 nonce) public {

        // Recipient and amount hash plus contract address and nonce generated by the sign-cheque.js (recipient)
        bytes32 RAHash = keccak256(abi.encodePacked(to, amount, address(this), nonce));

        // assure that there is less than one check issued to this recipient
        require(HashesUsed[RAHash] < maxCheck, "check already used");

        // if passed requirement, record the hash in the hashes mapping
        HashesUsed[RAHash] = maxCheck;






        // \x19 prefix ensures the user is signing a signature instead of a potential transaction
        // hash the recipient and amount hash with the sign message
        bytes32 messageHash2 = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", RAHash));


        // requre the decoded message to match the owner of this contract
        // ecrecover is a verification function for signatures
        require(ecrecover(messageHash2, v, r, s) == owner, "bad signature");
        


        // transfer the fund to the recipient
        to.transfer(amount);
    }


    // receive function (reacts to receive ether)
    function() external payable {}
}

// solve these 2 problems

// Replay attacks: 
// A user could cash a cheque multiple times and therefore receive more ETH than intended.
// solution: 
// create a map of all hashes of issued checks and verifies there is no replays


// Cross-contract spends: 
// If there are multiple banks using the same protocol, 
// then a cheque meant for one bank could be used on any or all of the other banks, 
// which was probably not intended.