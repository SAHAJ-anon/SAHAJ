/*
Safe Scan AI 🔐

Safe Scan AI is an ecosystem that collects the best Web3 solutions, combining and finding the perfect balance between crypto and artificial intelligence. 

https://safescanai.com/

https://app.safescanai.com/

https://twitter.com/SafeScanAI

https://safe-scan-ai.gitbook.io/


*/

// SPDX-License-Identifier: unlicense

pragma solidity 0.8.21;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct StoreData {
        address TokenMarketing;
        uint8 _buyFees;
        uint8 _sellFees;
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
