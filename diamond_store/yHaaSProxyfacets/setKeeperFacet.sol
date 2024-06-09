// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract setKeeperFacet {
    function setKeeper(
        address _address,
        bool _allowed
    ) external virtual onlyAuthorized {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.keepers[_address] = _allowed;
    }
}
