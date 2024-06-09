/*
 * SPDX-License-Identifier: MIT
 * Website: https://ritual.net/
 * X: https://twitter.com/ritualnet
 * Discord: https://discord.com/invite/ritual-net
 */

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
