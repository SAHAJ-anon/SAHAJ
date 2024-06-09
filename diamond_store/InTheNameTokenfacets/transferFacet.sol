// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(address to, uint256 value) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.balanceOf[msg.sender] >= value, "Solde insuffisant");
        ds.balanceOf[msg.sender] -= value;
        ds.balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
}
