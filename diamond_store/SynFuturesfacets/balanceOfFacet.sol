/*  
   * SPDX-License-Identifier: MIT 

     // Telegram: https://t.me/synfutures_Defi
    // Twitter: https://twitter.com/SynFuturesDefi
    // Website: https://www.synfutures.com/
    // Discord: https://discord.com/invite/qMX2kcQk7A
    

*/
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
