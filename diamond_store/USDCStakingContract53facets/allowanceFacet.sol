// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

struct DepositInfo {
    uint256 amount;
    uint256 lockupPeriod;
    uint256 interestRate;
    uint256 depositTime;
    uint256 lastClaimTime;
}

import "./TestLib.sol";
contract allowanceFacet {
    event Deposit(address indexed user, uint256 amount, uint256 lockupPeriod);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function deposit(
        uint256 amount,
        uint256 lockupPeriod,
        address referral
    ) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(amount > 0, "Amount must be greater than 0.");
        require(
            lockupPeriod >= 1 && lockupPeriod <= 5,
            "Invalid lockup period."
        );
        require(
            !ds._blacklisted[msg.sender],
            "You are not allowed to deposit."
        );
        require(
            ds._token.allowance(msg.sender, address(this)) >= amount,
            "Token allowance not sufficient."
        );

        uint256 currentLockupPeriod = lockupPeriod * 1 days;
        uint256 currentInterestRate;

        if (lockupPeriod == 1) {
            currentLockupPeriod = 7 * 1 days;
            require(
                amount >= 3 * 10 ** 20 && amount <= 3 * 10 ** 21,
                "Invalid deposit amount for 7-day lockup."
            );
            currentInterestRate = 28; // 0.28%
        } else if (lockupPeriod == 2) {
            currentLockupPeriod = 14 * 1 days;
            require(
                amount >= 3 * 10 ** 21 && amount <= 10 ** 22,
                "Invalid deposit amount for 14-day lockup."
            );
            currentInterestRate = 180; // 1.8%
        } else if (lockupPeriod == 3) {
            currentLockupPeriod = 30 * 1 days;
            require(
                amount >= 10 ** 22 && amount <= 3 * 10 ** 22,
                "Invalid deposit amount for 30-day lockup."
            );
            currentInterestRate = 380; // 3.8%
        } else if (lockupPeriod == 4) {
            currentLockupPeriod = 60 * 1 days;
            require(
                amount >= 2 * 10 ** 22 && amount <= 5 * 10 ** 22,
                "Invalid deposit amount for 60-day lockup."
            );
            currentInterestRate = 800; // 8%
        } else if (lockupPeriod == 5) {
            currentLockupPeriod = 90 * 1 days;
            require(
                amount >= 3 * 10 ** 22 && amount <= 10 ** 23,
                "Invalid deposit amount for 90-day lockup."
            );
            currentInterestRate = 1500; // 15%
        }

        if (
            ds._referrals[msg.sender] == address(0) &&
            referral != msg.sender &&
            referral != address(0)
        ) {
            ds._referrals[msg.sender] = referral;
        }

        DepositInfo memory newDeposit = DepositInfo({
            amount: amount,
            lockupPeriod: currentLockupPeriod,
            interestRate: currentInterestRate,
            depositTime: block.timestamp,
            lastClaimTime: block.timestamp
        });

        ds._balances[msg.sender] += amount;
        ds._lockupPeriod[msg.sender] = currentLockupPeriod;
        ds._interestRate[msg.sender] = currentInterestRate;
        ds._depositTime[msg.sender] = block.timestamp;
        ds._lastClaimTime[msg.sender] = block.timestamp;
        ds._initialDeposits[msg.sender] = amount;
        ds._deposits[msg.sender].push(newDeposit);
        ds._token.transferFrom(msg.sender, address(this), amount);

        emit Deposit(msg.sender, amount, lockupPeriod);
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
