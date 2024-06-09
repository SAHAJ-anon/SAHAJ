// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUniswapV3Router {
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function getWETH() external pure returns (address);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        uint256 maxWalletHold;
        uint256 buyTaxRate;
        uint256 sellTaxRate;
        uint256 initialTaxRate;
        uint256 initialTaxPeriod;
        address _taxRecipient;
        address _uniswapV3Router;
        address _owner;
        uint256 _startTime;
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
