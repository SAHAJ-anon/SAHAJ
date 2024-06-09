// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./TestLib.sol";
contract getAllowanceFacet {
    function getAllowance(
        address owner,
        address spender
    ) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.allowance[owner][spender];
    }
}
