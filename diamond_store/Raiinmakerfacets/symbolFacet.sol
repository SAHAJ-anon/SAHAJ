/*  
   * SPDX-License-Identifier: MIT

    //Telegram: https://t.me/raiinmakertalk
    // Twitter: https://twitter.com/raiinmakerapp
    // Website: https://www.raiinmaker.com/
    // Discord: https://discord.com/invite/nxWzdAKCBK
 
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
