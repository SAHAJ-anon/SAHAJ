// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address tokenAddress;
        mapping(bytes32 => undefined) roles;
        mapping(address => uint256) balances;
        bytes32 DEFAULT_ADMIN_ROLE;
        bytes32 REVIEWER_ROLE;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
