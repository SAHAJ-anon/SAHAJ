// SPDX-License-Identifier: MIT

// Telegram: https://t.me/lowgastoken
// Deploy TX: https://etherscan.io/tx/0xecb717e81b492fb2aaa63e3d2534395be5213bd33db084a3a7a18c68bc767599
// Runs (Optimizer) : 38
// EVM Version to target: Default

pragma solidity ^0.8.25;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string name;
        string symbol;
        uint256 decimals;
        uint256 totalSupply;
        mapping(address => uint256) t;
        mapping(address => undefined) z;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
