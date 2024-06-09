//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

interface IToken {
    function transferFrom(address from, address to, uint256 amount) external;
}

import "./TestLib.sol";
contract setFeeFacet {
    function setFee(uint8 _fee) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.fee = _fee;
    }
}
