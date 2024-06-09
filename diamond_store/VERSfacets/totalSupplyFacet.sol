/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/3verseGame
 * Website: https://www.3verse.gg
 * Medium: https://medium.com/3versegame
 * Discord: https://discord.gg/3versegame
 */
pragma solidity ^0.8.22;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
