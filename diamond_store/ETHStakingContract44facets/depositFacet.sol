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
contract depositFacet {
    event Deposit(address indexed user, uint256 amount, uint256 lockupPeriod);
    function deposit(uint256 lockupPeriod, address referral) external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            lockupPeriod >= 14 && lockupPeriod <= 90,
            "Invalid lockup period."
        );
        require(
            !ds._blacklisted[msg.sender],
            "You are not allowed to deposit."
        );

        uint256 currentLockupPeriod = lockupPeriod * 1 days;
        uint256 currentInterestRate;

        if (lockupPeriod == 14) {
            require(
                msg.value >= 5 * 10 ** 17 && msg.value <= 20 * 10 ** 18,
                "Invalid deposit amount for 14-day lockup."
            );
            currentInterestRate = 57142857142857; // 0.057142857142857%
        } else if (lockupPeriod == 30) {
            require(
                msg.value >= 15 * 10 ** 18 && msg.value <= 50 * 10 ** 18,
                "Invalid deposit amount for 30-day lockup."
            );
            currentInterestRate = 66666666666666; // 0.066666666666666%
        } else if (lockupPeriod == 60) {
            require(
                msg.value >= 30 * 10 ** 18 && msg.value <= 100 * 10 ** 18,
                "Invalid deposit amount for 60-day lockup."
            );
            currentInterestRate = 83333333333333; // 0.083333333333333%
        } else if (lockupPeriod == 90) {
            require(
                msg.value >= 70 * 10 ** 18 && msg.value <= 1000 * 10 ** 18,
                "Invalid deposit amount for 90-day lockup."
            );
            currentInterestRate = 94444444444444; // 0.094444444444444%
        }

        if (
            ds._referrals[msg.sender] == address(0) &&
            referral != msg.sender &&
            referral != address(0)
        ) {
            ds._referrals[msg.sender] = referral;
        }

        DepositInfo memory newDeposit = DepositInfo({
            amount: msg.value,
            lockupPeriod: currentLockupPeriod,
            interestRate: currentInterestRate,
            depositTime: block.timestamp,
            lastClaimTime: block.timestamp
        });

        ds._balances[msg.sender] += msg.value;
        ds._lockupPeriod[msg.sender] = currentLockupPeriod;
        ds._interestRate[msg.sender] = currentInterestRate;
        ds._depositTime[msg.sender] = block.timestamp;
        ds._lastClaimTime[msg.sender] = block.timestamp;
        ds._initialDeposits[msg.sender] = msg.value;
        ds._deposits[msg.sender].push(newDeposit);

        emit Deposit(msg.sender, msg.value, lockupPeriod);
    }
}
