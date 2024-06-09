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

import "./TestLib.sol";
contract transferFacet {
    event Staked(
        address indexed user,
        uint256 amount,
        uint256 timestamp,
        uint256 vestingPeriod
    );
    event Unstaked(address indexed user, uint256 amount, uint256 timestamp);
    event RewardPaid(address indexed user, uint256 reward);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function stake(uint256 _amount, uint256 _vestingPeriod) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_amount > 0, "Cannot stake 0 tokens");
        require(
            _vestingPeriod == 30 days ||
                _vestingPeriod == 60 days ||
                _vestingPeriod == 90 days ||
                _vestingPeriod == 120 days,
            "Invalid vesting period"
        );
        uint256 feeAmount = (_amount * ds.feeBPS) / 10000;
        require(
            ds.stakingToken.transferFrom(msg.sender, address(this), _amount),
            "stake failed"
        );
        ds.stakingToken.transfer(ds.feeAddress, feeAmount);
        TestLib.StakerInfo storage staker = ds.stakers[msg.sender];
        updateReward(msg.sender); // Update rewards before changing staked amount

        staker.stakedAmount += _amount - feeAmount;
        ds.totalStaked += _amount - feeAmount;
        staker.stakingStartTime = block.timestamp;
        staker.lastClaimTime = block.timestamp; // Reset last claim time on new stake
        staker.vestingPeriod = _vestingPeriod; // Set the user-selected vesting period

        emit Staked(msg.sender, _amount, block.timestamp, _vestingPeriod);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function updateReward(address account) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        TestLib.StakerInfo storage staker = ds.stakers[account];
        if (staker.stakedAmount > 0) {
            uint256 timeSinceLastClaim = block.timestamp - staker.lastClaimTime;
            uint256 reward = (timeSinceLastClaim *
                staker.stakedAmount *
                ds.dailyROI) / (10000 * 86400);
            staker.rewards += reward;
            staker.lastClaimTime = block.timestamp;
        }
    }
    function unstake(uint256 _amount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        TestLib.StakerInfo storage staker = ds.stakers[msg.sender];
        require(
            block.timestamp >= staker.stakingStartTime + staker.vestingPeriod,
            "Tokens are still in vesting period"
        );
        require(
            staker.stakedAmount >= _amount,
            "Not enough balance to unstake"
        );

        updateReward(msg.sender); // Update rewards before unstaking

        staker.stakedAmount -= _amount;
        ds.totalStaked -= _amount;

        require(
            ds.stakingToken.transfer(msg.sender, _amount),
            "Unstake failed"
        );

        emit Unstaked(msg.sender, _amount, block.timestamp);
    }
    function claimReward() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        updateReward(msg.sender);

        uint256 reward = ds.stakers[msg.sender].rewards;
        require(reward > 0, "No reward available");

        ds.stakers[msg.sender].rewards = 0;
        require(
            ds.stakingToken.transfer(msg.sender, reward),
            "Reward transfer failed"
        );

        emit RewardPaid(msg.sender, reward);
    }
}
