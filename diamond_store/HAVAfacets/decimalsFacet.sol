/*
 * SPDX-License-Identifier: MIT
 * Website: https://havacoin.xyz/
 * Twitter: https://twitter.com/Hava_Coin
 * Telegram Group: https://t.me/HavaCoinArmy
 * Telegram Channel:https://t.me/HavaCoinZone
 */
pragma solidity ^0.8.23;

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
