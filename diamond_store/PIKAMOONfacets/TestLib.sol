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

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct StoreData {
        address tokenMkt;
        uint8 Tax_buy;
        uint8 Tax_Sell;
    }
    struct TestStorage {
        string _name;
        string _symbol;
        uint8 decimals;
        uint256 totalSupply;
        StoreData storeData;
        uint256 swapAmount;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        address pair;
        IUniswapV2Router02 _uniswapV2Router;
        bool swapping;
        bool tradingOpen;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
