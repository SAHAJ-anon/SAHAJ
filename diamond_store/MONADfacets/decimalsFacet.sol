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
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
