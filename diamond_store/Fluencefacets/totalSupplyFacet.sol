/*  
   * SPDX-License-Identifier: MIT

      // Telegram: https://t.me/fluence_project
    // Twitter: https://twitter.com/fluence_project
    // Website: https://fluence.network/
    // Discord: https://discord.com/invite/5qSnPZKh7u
    // Medium:  https://medium.com/fluence_project
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
