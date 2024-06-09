// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract transferFromFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(value <= ds._balances[from]);
        require(value <= ds._allowed[from][msg.sender]);
        ds._balances[from] = ds._balances[from] - value;
        ds._allowed[from][msg.sender] = ds._allowed[from][msg.sender] - value;
        ds._balances[to] = ds._balances[to] + value;
        emit Transfer(from, to, value);
        return true;
    }
}
