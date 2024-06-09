//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

interface IToken {
    function transferFrom(address from, address to, uint256 amount) external;
}

import "./TestLib.sol";
contract setOwnerFacet {
    function setOwner(address _owner) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.owner = _owner;
    }
}
