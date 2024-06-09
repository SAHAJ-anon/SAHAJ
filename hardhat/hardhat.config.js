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
  solidity: '0.8.17',
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
      url: "http://localhost:32783", // replace with your geth node url
      chainId: 3151908, // replace with your geth node chainId
      accounts: ["bcdf20249abf0ed6d944c0288fad489e33f66b3960d9e6229c1cd214ed3bbe31", "39725efee3fb28614de3bacaffe4cc4bd8c436257e2c8bb887c4b5c4be45e76d"], // replace with your account private key
    },
    network2: {
      url: "http://localhost:32788", // replace with your geth node url
      chainId: 3151908, // replace with your geth node chainId
      accounts: ["39725efee3fb28614de3bacaffe4cc4bd8c436257e2c8bb887c4b5c4be45e76d", "bcdf20249abf0ed6d944c0288fad489e33f66b3960d9e6229c1cd214ed3bbe31"], // replace with your account private key
    },
	  // sepolia: {
		//   url: API_URL,
		//   accounts: [`0x${PRIVATE_KEY}`],
	  // },
  },
}
