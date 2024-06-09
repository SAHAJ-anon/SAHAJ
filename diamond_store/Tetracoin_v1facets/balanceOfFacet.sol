// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address owner) public view returns (uint256 balance) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[owner];
    }
}
