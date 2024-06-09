/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/bondexapp
    // Twitter: https://twitter.com/bondexapp
    // Website: https://bondex.app/
    // Github: https://github.com/bondexapp
    // Discord: https://discord.com/invite/drPUc34J2r
    // Medium: https://medium.com/@bondexapp

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
