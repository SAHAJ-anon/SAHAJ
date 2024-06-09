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
contract getLockupPeriodFacet {
    function getLockupPeriod(address user) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._lockupPeriod[user];
    }
}
