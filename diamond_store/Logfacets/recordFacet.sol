// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TestLib.sol";
contract recordFacet {
    function record(address _from, address _to, uint _value) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.history[_from][_to][block.timestamp] = _value;
    }
}
