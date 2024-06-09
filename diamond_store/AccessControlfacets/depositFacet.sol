// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./TestLib.sol";
contract depositFacet {
    function deposit() public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.value >= 1 ether, "Not enough ether");
        ds.balances[msg.sender] += msg.value;
    }
}
