/*
 * SPDX-License-Identifier: MIT
 * Website: https://airdrops.io/visit/wqk2/
 * Twitter: https://twitter.com/modenetwork
 * Telegram Channel: https://t.me/ModeNetworkOfficial
 * Discord Chat: https://discord.gg/modenetworkofficial
 */
pragma solidity ^0.8.20;

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
