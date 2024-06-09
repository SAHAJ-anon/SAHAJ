/*  
   * SPDX-License-Identifier: MIT 

    //Telegram: https://t.me/DFlowProtocol
    // Twitter: https://twitter.com/DFlowProtocol
    // Website: https://dflow.net/
    // Discord: https://discord.com/invite/dflow
    
    
   

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
