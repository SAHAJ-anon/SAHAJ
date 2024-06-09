// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract validateCallFacet {
    function validateCall(bytes32 callHash) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.validCalls[callHash] = true;
    }
}
