/* global ethers task */
require('@nomiclabs/hardhat-waffle')
require("hardhat-gas-reporter");
require('dotenv').config();
require('@nomiclabs/hardhat-ethers');

const { API_URL, PRIVATE_KEY } = process.env;

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
      },
      {
        version: "0.8.19",
      },
      {
        version: "0.8.9",
      },
      {
        version: "0.8.27",
      },
      {
        version: "0.8.25",
      },
      {
        version: "0.8.26",
      },
    ],
  },
  gas: 8000000000,
  settings: {
    optimizer: {
      enabled: true,
      runs: 20000
    }
  },
  gasReporter: {
    enabled: true
  },
  mocha: {
    timeout: 1000000000
  },
  networks: {
    network1: {
      url: "http://localhost:8545", // replace with your geth node url
      chainId: 31337, // replace with your geth node chainId
      accounts: ["0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80", "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d"], // replace with your account private key
    },
    network2: {
      url: "http://localhost:32781", // replace with your geth node url
      chainId: 31337, // replace with your geth node chainId
      accounts: ["39725efee3fb28614de3bacaffe4cc4bd8c436257e2c8bb887c4b5c4be45e76d", "bcdf20249abf0ed6d944c0288fad489e33f66b3960d9e6229c1cd214ed3bbe31"], // replace with your account private key
    },
	  // sepolia: {
		//   url: API_URL,
		//   accounts: [`0x${PRIVATE_KEY}`],
	  // },
  },
}
