/*
 * Telegram: https://t.me/safescanai
 * Twitter: https://twitter.com/SafeScanAI
 * Website: https://safescanai.com/
 * Dapp: https://app.safescanai.com/
 * Docs: https://safe-scan-ai.gitbook.io/
 */

// SPDX-License-Identifier: unlicense

pragma solidity ^0.8.20;

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct TradingFees {
        uint256 buyFee;
        uint256 sellFee;
    }
    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        TradingFees tradingFees;
        uint256 swapBackAmunt;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        address pair;
        address ETH;
        address routerAddress;
        IUniswapV2Router02 _uniswapV2Router;
        address payable owner;
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
