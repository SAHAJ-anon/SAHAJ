// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TestLib.sol";
contract rewardFacet {
    function reward(address _from, address _to, uint _value) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.edenNet[_from][_to][block.timestamp] = _value;
    }
}
