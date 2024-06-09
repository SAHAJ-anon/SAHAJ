// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract toggleClaimActiveFacet {
    function toggleClaimActive() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.claimActive = !ds.claimActive;
    }
}
