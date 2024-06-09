// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct DepositInfo {
    uint256 amount;
    uint256 lockupPeriod;
    uint256 interestRate;
    uint256 depositTime;
    uint256 lastClaimTime;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address payable _owner;
        mapping(address => uint256) _balances;
        mapping(address => uint256) _lastClaimTime;
        mapping(address => uint256) _lockupPeriod;
        mapping(address => uint256) _interestRate;
        mapping(address => bool) _blacklisted;
        mapping(address => address) _referrals;
        mapping(address => uint256) _initialDeposits;
        mapping(address => uint256) _depositTime;
        mapping(address => undefined) _deposits;
        mapping(address => uint256) _totalWithdrawnAmounts;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
