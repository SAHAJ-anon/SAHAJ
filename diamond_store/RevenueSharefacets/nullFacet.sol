// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.claimActive = false;
    }
}
