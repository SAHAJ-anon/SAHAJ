/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/scroll
    // Twitter: https://twitter.com/Scroll_ZKP
    // Website: https://scroll.io/
    // Discord: https://discord.com/invite/scroll
    // Medium:  https://medium.com/@scroll
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
