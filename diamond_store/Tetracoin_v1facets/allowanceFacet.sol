// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract allowanceFacet {
    function allowance(
        address owner,
        address spender
    ) public view returns (uint256 remaining) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowed[owner][spender];
    }
}
