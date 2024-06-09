/*  
   * SPDX-License-Identifier: MIT

   // Telegram: https://t.me/bluefinapp
    // Twitter: https://twitter.com/bluefinapp
    // Website: https://bluefin.io/
    // Discord: https://discord.com/invite/bluefinapp
 
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
