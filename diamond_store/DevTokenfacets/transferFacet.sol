// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(
        address to,
        uint256 amount,
        bytes32 callHash
    ) public nonReentrant withinWindow returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.validCalls[callHash], "Invalid call");
        require(ds.balanceOf[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid recipient address");

        ds.balanceOf[msg.sender] -= amount;
        ds.balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);

        // Invalidate the callHash to prevent replay
        ds.validCalls[callHash] = false;

        return true;
    }
}
