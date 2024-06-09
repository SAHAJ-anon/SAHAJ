/*
 * SPDX-License-Identifier: MIT
 * Telegram Channel: https://t.me/xpad_channel
 * Telegram Group (EN): https://t.me/xpad_group
 * Telegram Group (SNG): https://t.me/xpad_sng
 * Twitter: https://twitter.com/Xpad_pro
 * Reddit: https://www.reddit.com/r/xpad_pro
 * Linkedin: https://www.linkedin.com/company/xpadpro
 * Discord: https://discord.gg/g7XTZzCy8G
 * Medium: https://medium.com/@xpad.pro
 */
pragma solidity ^0.8.20;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address FACTORY;
        address ROUTER;
        address WETH;
        uint256 tokenTotalSupply;
        string tokenName;
        string tokenSymbol;
        address xxnux;
        uint8 tokenDecimals;
        mapping(address => uint256) _balances;
        mapping(address => undefined) _allowances;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
