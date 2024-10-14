// SPDX-License-Identifier: UNLICENSED

/*
    Website:  https://well3.com/
    Twitter:  https://twitter.com/well3official
    Discord:  https://discord.com/invite/yogapetz

*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply;
    }
}
