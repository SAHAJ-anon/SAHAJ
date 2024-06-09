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
contract getTotalWithdrawnAmountFacet {
    function getTotalWithdrawnAmount(
        address user,
        uint256 lockupPeriod
    ) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 totalWithdrawn = 0;
        for (uint256 i = 0; i < ds._deposits[user].length; i++) {
            if (ds._deposits[user][i].lockupPeriod == lockupPeriod * 1 days) {
                totalWithdrawn += ds._totalWithdrawnAmounts[user];
            }
        }
        return totalWithdrawn;
    }
}
