// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

import "./TestLib.sol";
contract getFacet {
    function get() public view returns (bytes32) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.messageData;
    }
}
