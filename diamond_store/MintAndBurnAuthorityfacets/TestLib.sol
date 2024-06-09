/**
 *Submitted for verification at Etherscan.io on 2022-10-08
 */

// KTON auth
pragma solidity ^0.4.24;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => bool) allowMintList;
        mapping(address => bool) allowBurnList;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
