// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._decimals;
    }
}
