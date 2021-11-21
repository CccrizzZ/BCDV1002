const ethers = require('ethers');
const crypto = require('crypto');



// private key and address of recipient wallet
let privateKey = '0x4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d';
let to = '0xffcf8fdee72ac11b5c542428b35eef5769c409f0';
let amount = '1.0';

// generate nonce for hashing
let randomBytes = crypto.randomBytes(32)
let nonce = ethers.utils.hexZeroPad(randomBytes, 32)

// presonal bank contract address
let personalBank = ''

// function to sign a payment
async function signPayment() {
    // construct recipient wallet obj
    let wallet = new ethers.Wallet(privateKey);

    // convert ether to wei
    let amountWei = ethers.utils.parseEther(amount);

    // HexZeroPad(x,length) will return x padded to length bytes
    // concat([]) convert bytes array into uint8 array
    let message = ethers.utils.concat([
        ethers.utils.hexZeroPad(to, 20),
        ethers.utils.hexZeroPad(ethers.utils.hexlify(amountWei), 32),   // hexlify convert int to hexstring
        ethers.utils.hexZeroPad(personalBank, 20),
        nonce
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



