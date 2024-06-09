/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/scallop_io
    // Twitter: https://twitter.com/Scallop_io
    // Website: https://www.scallop.io/
    // Github: https://github.com/scallop_io
    // Discord: https://discord.com/invite/F7umecFArJ
    // Medium: https://medium.com/scallopio

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
