// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract transferFacet {
    function transfer(address to, uint256 amount) external returns (bool);
    function claim(uint256 airdropAmount, uint256 presaleAmount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.startTime != 0 && block.timestamp >= ds.startTime,
            "Vesting has not started or start time not set"
        );

        uint256 totalAvailable = getTotalAvailableForClaim(
            msg.sender,
            presaleAmount,
            airdropAmount
        );
        require(totalAvailable > 0, "No tokens available for claim");

        TestLib.Allocation storage userAllocation = ds.allocations[msg.sender];

        if (!userAllocation.hasClaimedInitial) {
            userAllocation.hasClaimedInitial = true;

            uint256 monthsElapsed = (block.timestamp - ds.startTime) /
                ds.ONE_MONTH;

            uint256 totalClaimablePresale = 0;
            if (monthsElapsed >= 1) {
                totalClaimablePresale =
                    ((presaleAmount * ds.INITIAL_RELEASE_PERCENTAGE) / 10000) +
                    ((monthsElapsed *
                        ds.MONTHLY_RELEASE_PERCENTAGE *
                        presaleAmount) / 10000);
            } else {
                totalClaimablePresale =
                    (presaleAmount * ds.INITIAL_RELEASE_PERCENTAGE) /
                    10000;
            }
            totalClaimablePresale = totalClaimablePresale > presaleAmount
                ? presaleAmount
                : totalClaimablePresale;

            if (airdropAmount > 0) {
                uint256 totalInitialClaim = airdropAmount +
                    totalClaimablePresale;
                require(
                    totalInitialClaim <= ds.token.balanceOf(address(this)),
                    "Insufficient tokens in contract"
                );
                ds.token.transfer(msg.sender, totalInitialClaim);
                userAllocation.claimedAirdrop += airdropAmount;
                userAllocation.claimedPresale += totalClaimablePresale;
                userAllocation.airdrop += airdropAmount;
                userAllocation.presale += presaleAmount;
            } else {
                require(
                    totalClaimablePresale <= ds.token.balanceOf(address(this)),
                    "Insufficient tokens in contract"
                );
                ds.token.transfer(msg.sender, totalClaimablePresale);
                userAllocation.claimedPresale += totalClaimablePresale;
                userAllocation.presale += presaleAmount;
                userAllocation.airdrop += airdropAmount;
            }
        } else {
            uint256 monthsElapsed = (block.timestamp - ds.startTime) /
                ds.ONE_MONTH;
            uint256 totalClaimablePresale = (userAllocation.presale *
                ds.INITIAL_RELEASE_PERCENTAGE) /
                10000 +
                ((monthsElapsed *
                    ds.MONTHLY_RELEASE_PERCENTAGE *
                    userAllocation.presale) / 10000);
            totalClaimablePresale = totalClaimablePresale >
                userAllocation.presale
                ? userAllocation.presale
                : totalClaimablePresale;

            uint256 presaleToDistribute = totalClaimablePresale -
                userAllocation.claimedPresale;
            if (presaleToDistribute > 0) {
                require(
                    presaleToDistribute <= ds.token.balanceOf(address(this)),
                    "Insufficient tokens in contract"
                );
                ds.token.transfer(msg.sender, presaleToDistribute);
                userAllocation.claimedPresale += presaleToDistribute;
            }
        }
    }
    function getTotalAvailableForClaim(
        address userAddress,
        uint256 presaleAmount,
        uint256 airdropAmount
    ) public view returns (uint256 totalAvailable) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        TestLib.Allocation storage userAllocation = ds.allocations[userAddress];

        if (ds.startTime > block.timestamp) {
            return totalAvailable = 0;
        }

        uint256 monthsElapsed = (block.timestamp - ds.startTime) / ds.ONE_MONTH;
        uint256 availableAirdrop = 0;
        uint256 availablePresale = 0;

        bool hasClaimedInitial = userAllocation.hasClaimedInitial;
        uint256 userPresaleAmount = hasClaimedInitial
            ? userAllocation.presale
            : presaleAmount;
        uint256 userAirdropAmount = hasClaimedInitial
            ? userAllocation.airdrop
            : airdropAmount;

        if (
            !hasClaimedInitial &&
            block.timestamp <= ds.startTime + ds.AirdropForfeit
        ) {
            availableAirdrop = userAirdropAmount;
        }

        if (hasClaimedInitial) {
            uint256 totalClaimablePresale = (userPresaleAmount *
                ds.INITIAL_RELEASE_PERCENTAGE) /
                10000 +
                ((monthsElapsed *
                    ds.MONTHLY_RELEASE_PERCENTAGE *
                    userPresaleAmount) / 10000);
            totalClaimablePresale = totalClaimablePresale > userPresaleAmount
                ? userPresaleAmount
                : totalClaimablePresale;
            availablePresale =
                totalClaimablePresale -
                userAllocation.claimedPresale;
        } else if (monthsElapsed > 0) {
            uint256 initialPresaleRelease = (userPresaleAmount *
                ds.INITIAL_RELEASE_PERCENTAGE) / 10000;
            uint256 totalClaimablePresale = initialPresaleRelease +
                ((monthsElapsed *
                    ds.MONTHLY_RELEASE_PERCENTAGE *
                    userPresaleAmount) / 10000);
            totalClaimablePresale = totalClaimablePresale > userPresaleAmount
                ? userPresaleAmount
                : totalClaimablePresale;
            availablePresale = totalClaimablePresale;
        } else {
            availablePresale =
                (userPresaleAmount * ds.INITIAL_RELEASE_PERCENTAGE) /
                10000;
        }

        totalAvailable = availableAirdrop + availablePresale;
    }
    function balanceOf(address account) external view returns (uint256);
    function withdrawAllTokens() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 amount = ds.token.balanceOf(address(this));
        require(amount > 0, "No tokens to withdraw");
        ds.token.transfer(ds.treasuryContract, amount);
    }
    function withdrawTokens(uint256 amount) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(amount > 0, "Amount must be greater than 0");
        uint256 contractBalance = ds.token.balanceOf(address(this));
        require(amount <= contractBalance, "Insufficient balance in contract");

        ds.token.transfer(ds.treasuryContract, amount);
    }
}
