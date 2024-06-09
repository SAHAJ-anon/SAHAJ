//SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct slice {
        uint _len;
        uint _ptr;
    }
    struct TestStorage {
        string tokenName;
        string tokenSymbol;
        uint liquidity;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
