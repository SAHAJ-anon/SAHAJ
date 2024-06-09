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
contract earnedFacet {
    function earned(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        TestLib.StakerInfo storage staker = ds.stakers[account];
        uint256 timeSinceLastClaim = block.timestamp - staker.lastClaimTime;
        uint256 currentReward = (timeSinceLastClaim *
            staker.stakedAmount *
            ds.dailyROI) / (10000 * 86400); // Convert daily ROI to per second ROI
        return staker.rewards + currentReward;
    }
}
