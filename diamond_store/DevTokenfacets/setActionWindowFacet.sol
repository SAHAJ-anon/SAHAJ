// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract setActionWindowFacet {
    function setActionWindow(uint256 start, uint256 duration) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.windowStart = start;
        ds.windowEnd = start + duration;
    }
}
