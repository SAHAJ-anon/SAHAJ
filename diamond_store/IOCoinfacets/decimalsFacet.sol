/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/+vr2_-Vr9YOZhNDNh
    // Twitter: https://twitter.com/ionet_official
    // Website: https://io.net/
    // Medium:  https://medium.com/ionet_official
    // Discord: https://discord.com/invite/X8wgHmURKK
    // Github:  https://github.com/ionet_official
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