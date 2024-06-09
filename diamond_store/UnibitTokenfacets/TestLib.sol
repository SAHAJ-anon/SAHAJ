// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        mapping(address => uint256) nonces;
        bytes32 DOMAIN_SEPARATOR;
        bytes32 PERMIT_TYPEHASH;
        bytes32 DOMAIN_TYPEHASH;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
