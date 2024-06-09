/*  
   * SPDX-License-Identifier: MIT
   * Twitter: https://twitter.com/satoshiDEX_ai
   * Website: https://satoshidex.ai/
   * Telegram :https://t.me/SatoshiDEXAI
   
*/
pragma solidity ^0.8.18;

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
