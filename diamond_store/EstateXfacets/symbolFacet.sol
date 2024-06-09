/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://twitter.com/estatexeu
    // Twitter: https://twitter.com/estatexeu
    // Website: https://www.estatex.eu/
    // Discord: https://discord.com/invite/ywcRSgNNDJ
    // Medium:  https://estatexeurope.medium.com/
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
