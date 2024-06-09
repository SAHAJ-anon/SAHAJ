/*
 * SPDX-License-Identifier: MIT
 * Facebook:https://www.facebook.com/LegendsOfElysium/
 * Telegram: https://t.me/legendsofelysium_ann
 * Twitter: https://twitter.com/LegendsElysium
 * Website: https://legendsofelysium.io/?utm_source=icodrops
 * Discord: https://discord.com/invite/TnbyVTyYjv
 * Youtube: https://www.youtube.com/channel/UCn9UlLgiKG_dqOWVqYAENvQ
 * Medium: https://medium.com/@legendsofelysium
 */
pragma solidity ^0.8.23;

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
