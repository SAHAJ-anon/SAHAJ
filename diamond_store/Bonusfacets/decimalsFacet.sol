/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/bonusblock
    // Twitter: https://twitter.com/bonus_block
    // Website: https://www.bonusblock.io/
    // Discord: https://discord.com/invite/ZURpsSsuEF
 
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