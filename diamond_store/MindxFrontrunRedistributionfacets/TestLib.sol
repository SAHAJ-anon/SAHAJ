//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.4;

// In the tx 0xe474bba90d66465dfbc5ee935f77f4a1ca7e0838960054926727e763e08c0c67 a frontrun of a Mindx Rug happened.
// Due to the weird circumstances surrounding the original transaction I've decided that a direct permissionless refund makes more sense.
// The refund will remain open for a few months, after that point I will reposess the remaining assets. One can reach out via Etherscan / Blockscan and I will manually refund once that point has passed.

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address owner_;
        mapping(address => bool) claimed_;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
