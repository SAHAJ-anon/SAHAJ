/*

Centered around immersive 3D graphics, artistry, and gameplay, Pikamoon is building one of the world's most advanced GameFi metaverses.
$PIKA is the native token of Pikamoon and the surrounding Pikaverse.
Once acquired, $PIKA can be used to purchase special in-game items via the Pikamoon Store - be it magic boosts, health potions, weapons, and more. 
These upgrades will help bolster your Play-to-Earn journey throughout Dreva.

🔗 Useful links:
Website - https://pikamoon.io
Twitter - https://twitter.com/pikamooncoin
Telegram - https://t.me/pikamoonofficial
Discord - https://discord.gg/s2a9DSYYet

*/

// SPDX-License-Identifier: unlicense

pragma solidity ^0.8.20;

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._name = unicode"PIKAMOON";
        ds._symbol = unicode"PIKA";
        ds.decimals = 18;
        ds.totalSupply = 50_000_000_000 * 10 ** ds.decimals;
        ds.swapAmount = ds.totalSupply / 100;
        ds._uniswapV2Router = IUniswapV2Router02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );
    }
}
