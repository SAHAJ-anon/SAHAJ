/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/PolyhedraZK
    // Twitter: https://twitter.com/PolyhedraZK
    // Website: https://polyhedra.network/
    // Github: https://github.com/PolyhedraZK
    // Discord: https://discord.com/invite/WkjUe5tfZP
    // Medium: https://polyhedra.medium.com/
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
