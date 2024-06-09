/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/starrynift
    // Twitter: https://twitter.com/StarryNift
    // Website: https://app.starrynift.art/index
    // Discord: https://discord.com/invite/JKQw4XE9Rs
    // Medium:  https://medium.com/@starrynift
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
