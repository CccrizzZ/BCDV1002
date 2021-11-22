const ethers = require('ethers');
const crypto = require('crypto');



// private key of sender
let privateKey = '6d36bf1b9fdd209a2a63d0c245d994df53725f6c3bd87f41065db0d69d9a1d08';

// recipient address
let to = '0xD1b6A3D73F29E078D8E0119Ec253293eCD5B0eA7';

// amount of ether to send
let amount = '1.0';

// generate nonce for hashing
let randomBytes = crypto.randomBytes(32)
let nonce = ethers.utils.hexZeroPad(randomBytes, 32)

// presonal bank contract address
let personalBank = '0x2b7Ad386A165ecEC194B428c66E5A022934f0eA3'

// function to sign a payment
async function signPayment() {
    // construct recipient wallet obj
    let wallet = new ethers.Wallet(privateKey);

    // convert ether to wei
    let amountWei = ethers.utils.parseEther(amount);

    // HexZeroPad(x,length) will return x padded to length bytes
    // concat([]) convert bytes array into uint8 array
    let message = ethers.utils.concat([
        ethers.utils.hexZeroPad(to, 20),  // to address
        ethers.utils.hexZeroPad(ethers.utils.hexlify(amountWei), 32),  // amount // hexlify convert int to hexstring
        ethers.utils.hexZeroPad(personalBank, 20),   // contract address
        nonce  // nonce generated
    ]);

    // create message hash
    let messageHash = ethers.utils.keccak256(message);

    // create RawSignature of input message
    let sig = await wallet.signMessage(ethers.utils.arrayify(messageHash));
    
    // split signature returns full expanded format of aSignaturelike
    let splitSig = ethers.utils.splitSignature(sig);

    console.log(`to: ${to}`);
    console.log(`amount: ${amountWei}`);
    console.log();
    console.log(`r: ${splitSig.r}`);
    console.log(`s: ${splitSig.s}`);
    console.log(`v: ${splitSig.v}`);
    console.log(`nonce: ${nonce}`);
    console.log(`contract address: ${personalBank}`);


}

signPayment();



