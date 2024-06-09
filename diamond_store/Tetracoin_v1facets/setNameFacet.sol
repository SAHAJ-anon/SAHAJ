// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract setNameFacet {
    function setName(string memory __name) external isOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(bytes(__name).length > 0);
        ds._name = __name;
    }
}
