// SPDX-License-Identifier: UNLICENSED

/*
    Website:  https://anvm.io/
    Twitter:  https://twitter.com/AINNLayer2
    Telegram:  https://t.me/AINN_ANVM

*/

pragma solidity ^0.8.24;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply;
    }
}
