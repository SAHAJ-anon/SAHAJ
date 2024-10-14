// SPDX-License-Identifier: UNLICENSED

/*
    Website:  https://cookie3.co/
    Twitter:  https://twitter.com/cookie3_co
    Medium:   hhttps://medium.com/@cookie3
    Discord:  https://discord.com/invite/cookie3
    Telegram: https://t.me/cookie3_co

*/

pragma solidity ^0.8.24;
import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._tokename;
    }
}
