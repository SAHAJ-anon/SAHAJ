// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TestLib.sol";
contract allowanceFacet {
    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
}
