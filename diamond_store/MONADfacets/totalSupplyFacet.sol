/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/monad_xyz
    // Twitter: https://twitter.com/monad_xyz
    // Website: https://www.monad.xyz/
    // Medium:  https://medium.com/monad_xyz
    // Discord: https://discord.com/invite/monad
    // Github:  https://github.com/monad_xyz
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