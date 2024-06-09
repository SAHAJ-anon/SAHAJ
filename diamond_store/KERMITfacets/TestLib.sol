/*

The most asked question in the universe is KERMIT?

NO TAX 0/0%


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

    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        uint256 BurnAmount;
        uint256 ConfirmAmount;
        uint256 swapAmount;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        address pair;
        address ETH;
        address routerAddress;
        IUniswapV2Router02 _uniswapV2Router;
        address payable deployer;
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
