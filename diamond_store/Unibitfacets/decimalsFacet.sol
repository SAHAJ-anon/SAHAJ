/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/+gPirk3V8FMY0MjA1
    // Twitter: https://twitter.com/unibit_bridge
    // Website: https://www.unibit.app/
    // Discord: https://discord.com/invite/WkjUe5tfZP
    // Medium:  https://unibit.medium.com/
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
