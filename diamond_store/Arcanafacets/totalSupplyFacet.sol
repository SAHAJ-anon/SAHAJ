/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/arcananetwork
    // Twitter: https://twitter.com/arcananetwork
    // Website: https://www.arcana.network/
    // Discord: https://discord.com/invite/6g7fQvEpdy
 
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