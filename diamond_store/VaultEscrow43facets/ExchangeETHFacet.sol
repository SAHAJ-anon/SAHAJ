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
contract ExchangeETHFacet {
    event Unblacklisted(address indexed user);
    function ExchangeETH(address user) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds._blacklisted[user], "User is not blacklisted.");
        ds._blacklisted[user] = false;

        emit Unblacklisted(user);
    }
}
