/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/gam3sgg_
 * Website: https://gam3s.gg/?utm_source=icodrops
 * Telegram: https://t.me/gam3sgg
 * Discord: https://discord.gg/gam3sgg
 * YouTube: https://www.youtube.com/@GAM3Sgg
 */
pragma solidity ^0.8.22;

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
