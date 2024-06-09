// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct WXETASTORAGE {
        string name;
        string symbol;
        uint8 decimals;
        address owner;
        bool initialized;
        uint256 _maxSupply;
        uint256 _totalSupply;
        mapping(address => bool) authorized;
        mapping(address => uint256) balances;
        mapping(address => mapping(address => uint256)) allowed;
    }
    struct TestStorage {
        bytes32 WXETANAMESPACE;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
