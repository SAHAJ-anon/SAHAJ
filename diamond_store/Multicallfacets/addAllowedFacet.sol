// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

/// @title Multicall - Aggregate results from multiple read-only function calls
/// @author Nick Johnson <arachnid@notdot.net>

import "./TestLib.sol";
contract addAllowedFacet {
    function addAllowed(address addressToAdd) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds.owner);
        ds.allowed[addressToAdd] = true;
    }
}
