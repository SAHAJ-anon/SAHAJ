// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract setDecimalsFacet {
    function setDecimals(uint8 __decimals) external isOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(__decimals >= 0 && __decimals <= 16);
        ds._decimals = __decimals;
    }
}
