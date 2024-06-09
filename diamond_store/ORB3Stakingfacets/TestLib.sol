/**
 *Submitted for verification at Etherscan.io on 2024-03-11
 */

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct StakerInfo {
        uint256 stakedAmount;
        uint256 stakingStartTime;
        uint256 lastClaimTime;
        uint256 rewards;
        uint256 vestingPeriod; // User-selected vesting period in seconds
    }
    struct TestStorage {
        IERC20 stakingToken;
        address owner;
        uint256 dailyROI;
        address feeAddress;
        uint256 feeBPS;
        uint256 totalStaked;
        mapping(address => undefined) stakers;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
