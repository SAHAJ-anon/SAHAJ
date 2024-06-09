//SPDX-License-Identifier: UNLICENSED

/*
 * Telegram: https://t.me/safescanai
 * Twitter: https://twitter.com/SafeScanAI
 * Website: https://safescanai.com/
 * Dapp: https://app.safescanai.com/
 * Docs: https://safe-scan-ai.gitbook.io/
 */

pragma solidity ^0.8.0;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string SYMBOL;
        uint8 DECIMALS;
        string NAME;
        uint256 TOTAL_SUPPLY;
        mapping(address => uint256) _balances;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
