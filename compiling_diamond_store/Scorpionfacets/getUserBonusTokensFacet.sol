// SPDX-License-Identifier: MIT
// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol

// OpenZeppelin Contracts (last updated v5.0.0) (utils/Address.sol)

pragma solidity ^0.8.20;
import "./TestLib.sol";
contract getUserBonusTokensFacet {
    using Counters for Counters.Counter;
    using SafeERC20 for IERC20;

    function getUserBonusTokens(
        address _userAddress
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.totalUserBonusTokens[_userAddress];
    }
}
