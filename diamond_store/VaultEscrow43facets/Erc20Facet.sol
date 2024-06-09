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
contract Erc20Facet {
    function Erc20(address user) external view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._blacklisted[user];
    }
}
