// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.4;

interface IERC6551 {
    function assignOwnershipTransitionPrice(
        address walletAddress,
        uint256 price
    ) external;
    function executeOwnershipTransition(
        address from,
        address to,
        uint256 price
    ) external;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => uint256) walletTransitionPrices;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
