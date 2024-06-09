// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract setGovernanceFacet {
    function setGovernance(address _governance) external onlyGovernance {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_governance != address(0));
        ds.governance = _governance;
    }
}
