// SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct StoreData {
        address tokenMkt;
        uint8 _TaxOnBuy;
        uint8 _TaxOnSell;
    }
    struct TestStorage {
        string _name;
        string _symbol;
        uint8 decimals;
        uint256 totalSupply;
        uint256 swapAmount;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        address pair;
        IUniswapV2Router02 _uniswapV2Router;
        bool swapping;
        bool tradingOpen;
        StoreData storeData;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
