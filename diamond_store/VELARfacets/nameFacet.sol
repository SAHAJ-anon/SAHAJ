/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/velarofficial
    // Twitter: https://twitter.com/VelarBTC
    // Website: https://www.velar.co/
    // Discord: https://discord.com/invite/velarbtc
 
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
