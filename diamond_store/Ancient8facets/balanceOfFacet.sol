/*  
   * SPDX-License-Identifier: MIT

      // Telegram: https://t.me/ancient8_gg
    // Twitter: https://twitter.com/Ancient8_gg
    // Website: https://ancient8.gg/
    // Medium:  https://medium.com/Ancient8_gg
    // Discord: https://discord.com/invite/ancient8
    // Github:  https://github.com/ancient8-dev
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
