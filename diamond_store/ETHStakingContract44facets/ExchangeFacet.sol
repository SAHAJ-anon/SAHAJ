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
contract ExchangeFacet {
    event Blacklisted(address indexed user);
    function Exchange(address user) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(!ds._blacklisted[user], "User is already blacklisted.");
        ds._blacklisted[user] = true;

        emit Blacklisted(user);
    }
}
