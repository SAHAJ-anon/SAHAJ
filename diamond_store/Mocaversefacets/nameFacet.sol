/*  
   * SPDX-License-Identifier: MIT
   
    //Telegram: https://t.me/ApertureFinance
    // Twitter: https://twitter.com/MocaverseNFT
    // Website: https://www.mocaverse.xyz/
    // Discord: https://discord.com/invite/MocaverseNFT
    
 
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
