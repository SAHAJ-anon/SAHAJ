// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./TestLib.sol";
contract transferFromFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.balanceOf[from] >= value, "Solde insuffisant");
        require(
            ds.allowance[from][msg.sender] >= value,
            "Autorisation insuffisante"
        );
        ds.balanceOf[from] -= value;
        ds.balanceOf[to] += value;
        ds.allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}
