// Lab2 create transactions
const ethers = require('ethers')

// create ether provider
const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545")

// function for getting the balance of address in provider network (in eth or wei)
const GetBalance = async (address) => {
  const balance = await provider.getBalance(address)
  
  // balance in wei
  // const wei = parseInt(balance._hex, 16)
  // console.log(wei + " wei")

  // balance in ether
  const ether = parseInt(balance._hex, 16) / Math.pow(10, 18)
  // console.log(ether + " eth")

  // returns the balance in ether
  return ether
}

// ganache account
const Address1 = "0x72441AaDf4AE7bD86349B3C1C69dB66f0467293f"
const PrivateKey1 = "c4c5a6c550f32c1176709cb78a8d0eddb221723d3d95cd991ea93a1c0ff98311"
const GanacheWallet1 = new ethers.Wallet(PrivateKey1, provider)

// my metamask account
const MyAddress = "0x80E129d94cEfB5ccB2DF24A906e576762426e952"

// feed back: use async/await next time instead of then
// send from ganache account to metamask
GanacheWallet1.sendTransaction({
  to: MyAddress,
  value: ethers.utils.parseEther("1") // 1 ether
}).then((res) => {
  console.log(res)

  // get balance of genache account
  GetBalance(Address1).then((res) => {
    console.log("Ganache account balance: " + res + " eth")
  })


  // get my metamask balance
  GetBalance(MyAddress).then((res) => {
    console.log("My balance: " + res + " eth")
  })

})
