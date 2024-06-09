// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

/**
 * @title Singleton Factory (EIP-2470)
 * @dev Extended version from EIP-2470 for testing purposes
 * @author Ricardo Guilherme Schmidt (Status Research & Development GmbH)
 */
library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address lastDeployedContract;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
