/*  
   * SPDX-License-Identifier: MIT 

    // Telegram: https://t.me/overtrip
    // Twitter: https://twitter.com/playovertrip
    // Website: https://www.overtrip.com/
    // Discord: https://discord.com/invite/overtrip
    
    

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
