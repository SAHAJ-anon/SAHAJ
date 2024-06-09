// SPDX-License-Identifier: MIT
//Telegram: https://t.me/gaslesstoken
pragma solidity ^0.8.25;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        uint256 totalSupply;
        mapping(address => uint256) b;
        mapping(address => undefined) a;
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
