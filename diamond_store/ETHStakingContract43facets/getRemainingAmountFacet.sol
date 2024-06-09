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
contract getRemainingAmountFacet {
    function getRemainingAmount(address user) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 totalDeposits = 0;
        uint256 totalRemaining = 0;

        for (uint256 i = 0; i < ds._deposits[user].length; i++) {
            totalDeposits += ds._deposits[user][i].amount;
            if (ds._deposits[user][i].amount > 0) {
                totalRemaining += ds._deposits[user][i].amount;
            }
        }

        return totalDeposits - totalRemaining;
    }
}
