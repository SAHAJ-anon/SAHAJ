// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./TestLib.sol";
contract addDiceBalanceFacet {
    function addDiceBalance() public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.balances[msg.sender] += msg.value;
    }
}
