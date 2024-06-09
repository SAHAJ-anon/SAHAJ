/*  
   * SPDX-License-Identifier: MIT

   // Telegram: https://t.me/arcade2earn
    // Twitter: https://twitter.com/arcade2earn
    // Website: https://www.arcade2earn.io/
    // Discord: https://discord.com/invite/hhCm89Tsn7
 
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
