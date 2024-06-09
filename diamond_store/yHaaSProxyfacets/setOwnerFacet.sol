// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract setOwnerFacet {
    function setOwner(address _owner) external onlyAuthorized {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_owner != address(0));
        ds.owner = _owner;
    }
}
