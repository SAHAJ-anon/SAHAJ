// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(address to, uint256 value) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(value <= ds._balances[msg.sender]);
        ds._balances[msg.sender] = ds._balances[msg.sender] - value;
        ds._balances[to] = ds._balances[to] + value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
}
