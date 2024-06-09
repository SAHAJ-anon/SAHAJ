/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/Entanglefi
    // Twitter: https://twitter.com/Entanglefi
    // Website: https://entangle.fi/
    // Github: https://github.com/Entanglefi
    // Discord: https://discord.com/invite/entangle
    // Medium: https://medium.com/Entanglefi/
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
