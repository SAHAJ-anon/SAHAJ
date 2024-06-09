// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
// Telegram: https://t.me/FeeLessPortal
library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        uint256 totalSupply;
        mapping(address => uint256) _balances;
        mapping(address => undefined) _allowances;
        string name;
        string symbol;
        uint8 decimals;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
