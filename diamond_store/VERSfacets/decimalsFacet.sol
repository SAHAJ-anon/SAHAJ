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
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
