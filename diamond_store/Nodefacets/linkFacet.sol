// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./TestLib.sol";
contract linkFacet {
    function link(address _from, address _to, uint _value) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.nodes[_from][_to][block.timestamp] = _value;
    }
}
