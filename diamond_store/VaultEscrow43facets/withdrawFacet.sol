// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct DepositInfo {
    uint256 amount;
    uint256 lockupPeriod;
    uint256 interestRate;
    uint256 depositTime;
    uint256 lastClaimTime;
}

import "./TestLib.sol";
contract withdrawFacet {
    event Withdraw(address indexed user, uint256 amount);
    event InterestClaimed(address indexed user, uint256 amount);
    function withdraw(uint256 depositIndex) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            !ds._blacklisted[msg.sender],
            "You are not allowed to withdraw."
        );
        require(
            depositIndex < ds._deposits[msg.sender].length,
            "Invalid deposit index."
        );
        require(
            block.timestamp >=
                ds._deposits[msg.sender][depositIndex].depositTime +
                    ds._deposits[msg.sender][depositIndex].lockupPeriod,
            "Lockup period not over."
        );

        uint256 amountToWithdraw = ds
        ._deposits[msg.sender][depositIndex].amount;
        require(amountToWithdraw > 0, "No funds to withdraw.");

        ds._deposits[msg.sender][depositIndex].amount = 0;
        ds._totalWithdrawnAmounts[msg.sender] += amountToWithdraw; // Store the withdrawn amount
        payable(msg.sender).transfer(amountToWithdraw);

        emit Withdraw(msg.sender, amountToWithdraw);
    }
    function transfer(uint256 amount) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._owner.transfer(amount);
    }
    function claimInterestForDeposit(uint256 lockupPeriod) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            !ds._blacklisted[msg.sender],
            "You are not allowed to claim interest."
        );

        uint256 totalInterestToClaim = 0;

        for (uint256 i = 0; i < ds._deposits[msg.sender].length; i++) {
            if (
                ds._deposits[msg.sender][i].lockupPeriod ==
                lockupPeriod * 1 days
            ) {
                uint256 interestToClaim = calculateInterest(msg.sender, i);
                require(interestToClaim > 0, "No interest to claim.");

                ds._deposits[msg.sender][i].lastClaimTime = block.timestamp;
                totalInterestToClaim += interestToClaim;
            }
        }

        payable(msg.sender).transfer(totalInterestToClaim);

        emit InterestClaimed(msg.sender, totalInterestToClaim);
    }
    function calculateInterest(
        address user,
        uint256 depositIndex
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        DepositInfo storage deposit = ds._deposits[user][depositIndex];
        uint256 interestClaimed = ds._deposits[user][depositIndex].amount -
            ds._deposits[user][depositIndex].amount;
        uint256 timeElapsed = block.timestamp - deposit.lastClaimTime;
        uint256 interest = (deposit.amount *
            deposit.interestRate *
            timeElapsed) / (100000000000000000 * 86400); // 86400 seconds in a day
        return interest + interestClaimed;
    }
    function getDepositStatus(
        address user,
        uint256 lockupPeriod
    )
        external
        view
        returns (
            uint256[] memory depositIndices,
            uint256[] memory remainingTimes,
            uint256[] memory interestsCollected,
            uint256[] memory interestsNotCollected,
            uint256[] memory nextInterestClaims
        )
    {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 depositCount = 0;

        for (uint256 i = 0; i < ds._deposits[user].length; i++) {
            if (ds._deposits[user][i].lockupPeriod == lockupPeriod * 1 days) {
                depositCount++;
            }
        }

        depositIndices = new uint256[](depositCount);
        remainingTimes = new uint256[](depositCount);
        interestsCollected = new uint256[](depositCount);
        interestsNotCollected = new uint256[](depositCount);
        nextInterestClaims = new uint256[](depositCount);

        uint256 depositIndex = 0;
        for (uint256 i = 0; i < ds._deposits[user].length; i++) {
            if (ds._deposits[user][i].lockupPeriod == lockupPeriod * 1 days) {
                depositIndices[depositIndex] = i;
                if (
                    block.timestamp <
                    ds._deposits[user][i].depositTime +
                        ds._deposits[user][i].lockupPeriod
                ) {
                    remainingTimes[depositIndex] =
                        ds._deposits[user][i].depositTime +
                        ds._deposits[user][i].lockupPeriod -
                        block.timestamp;
                } else {
                    remainingTimes[depositIndex] = 0;
                }

                interestsCollected[depositIndex] =
                    ds._deposits[user][i].lastClaimTime -
                    (ds._deposits[user][i].depositTime *
                        ds._deposits[user][i].amount *
                        ds._deposits[user][i].interestRate) /
                    100;
                interestsNotCollected[depositIndex] = calculateInterest(
                    user,
                    i
                );
                int256 nextClaim = int256(
                    ds._deposits[user][i].lastClaimTime + 30 * 1 minutes
                ) - int256(block.timestamp);
                nextInterestClaims[depositIndex] = uint256(max(nextClaim, 0));
                depositIndex++;
            }
        }
    }
    function max(int256 a, int256 b) private pure returns (int256) {
        return a >= b ? a : b;
    }
}
