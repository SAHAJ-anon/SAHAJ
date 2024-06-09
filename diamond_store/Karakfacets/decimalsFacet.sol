/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/Karak_Network
    // Twitter: https://twitter.com/Karak_Network
    // Website: https://karak.network/
    // Discord: https://discord.com/invite/7nJEVrw4Fh
    // Medium: https://medium.com/@Karak_Network

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
