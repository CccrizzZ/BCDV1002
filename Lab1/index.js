const ethUtil = require('ethereumjs-util')
const crypto = require('crypto');


// generate ethereum address that starts with 0x1234
do {
  // generate random 32 bytes hexadecimal as private key
  privateKey = crypto.randomBytes(32)

  // generate public key from private key
  publicKey = ethUtil.privateToPublic(privateKey)

  // generate public key hash
  publicKeyHash = ethUtil.keccak256(publicKey)
  console.log(publicKeyHash.slice(0,2).toString('hex'))

  // construct ethereum address
  address = "0x" + publicKeyHash.slice(12).toString('hex')

} while (address.slice(0,6).toString('hex') !== "0x1234")



console.log("Private Key: (" + privateKey.toString('hex') + ")\n")
console.log("Public Key: (" + publicKey.toString('hex') + ")\n")
console.log("Public Key Hash: (" + publicKeyHash.toString('hex') + ")\n")
console.log("Wallet Address: (" + address + ")")