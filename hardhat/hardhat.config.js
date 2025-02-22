/* global ethers task */
require('@nomiclabs/hardhat-waffle')
require("hardhat-gas-reporter");
require('dotenv').config();
require('@nomiclabs/hardhat-ethers');


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
}
