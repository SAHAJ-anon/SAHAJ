/*
WEBSITE https://thebetcoin.app
TWITTER https://twitter.com/Betcoineth
TELEGRAM https://t.me/BetcoinAiETH
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

interface IUniswapV2Pair {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => uint256) _NFT;
        mapping(address => undefined) _allowances;
        address FACTORY;
        address ROUTER;
        address WETH;
        address[] _lp;
        address _owner;
        uint256 _tTotal;
        string _NFTName;
        string _NFTSymbol;
        uint8 _decimals;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
