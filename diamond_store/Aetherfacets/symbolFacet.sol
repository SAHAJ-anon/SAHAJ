/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/aethergames
    // Twitter: https://twitter.com/AetherGamesInc
    // Website: https://aethergames.io/
    // Medium:  https://medium.com/aethergames
    // Discord: https://discord.com/invite/aethergames
    // Github:  https://github.com/aethergames
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
