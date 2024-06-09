/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/ponderone
    // Twitter: https://twitter.com/Ponder_One
    // Website: https://ponder.one/
    // Medium:  https://medium.com/@ponder-one
    // Discord: https://discord.com/invite/dYpdSckNnd
    // Github:  https://github.com/Ponder_One
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
