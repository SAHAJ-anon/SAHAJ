// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.6;

interface IERC20 {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external;

    function transfer(address to, uint256 value) external;

    function transferFrom(address from, address to, uint256 value) external;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct Stake {
        uint256 unstaketime;
        uint256 staketime;
        uint256 amount;
        uint256 rewardTokenAmount;
        uint256 reward;
        uint256 lastharvesttime;
        uint256 remainingreward;
        uint256 harvestreward;
        uint256 persecondreward;
        bool withdrawan;
        bool unstaked;
    }
    struct User {
        uint256 totalStakedTokenUser;
        uint256 totalUnstakedTokenUser;
        uint256 totalClaimedRewardTokenUser;
        uint256 stakeCount;
        bool alreadyExists;
    }
    struct TestStorage {
        IERC20 stakeToken;
        IERC20 rewardToken;
        IERC20 token3;
        address payable owner;
        uint256 maxStakeableToken;
        uint256 minimumStakeToken;
        uint256 totalUnStakedToken;
        uint256 totalStakedToken;
        uint256 totalClaimedRewardToken;
        uint256 totalStakers;
        uint256 percentDivider;
        uint256 totalFee;
        uint256[4] Duration;
        uint256[4] Bonus;
        mapping(address => undefined) Stakers;
        mapping(uint256 => address) StakersID;
        mapping(address => undefined) stakersRecord;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
