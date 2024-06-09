/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/truflation
    // Twitter: https://twitter.com/Parcl
    // Website: https://truflation.com/
    // Discord: https://discord.com/invite/5AMCBYxfW4
 
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
