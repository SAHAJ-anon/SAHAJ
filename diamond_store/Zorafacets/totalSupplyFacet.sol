/*  
   * SPDX-License-Identifier: MIT 

    //Telegram: https://t.me/ourZORA
    // Twitter: https://twitter.com/ourZORA
    // Website: https://zora.co/
    // Discord: https://discord.com/invite/Va58aMrcwk
    
    
   

*/
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
