/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/NuLink2021
    // Twitter: https://twitter.com/NuLink_
    // Website: https://www.nulink.org/
    // Medium:  https://medium.com/NuLink_
    // Discord: https://discord.com/invite/25CQFUuwJS
    // Github:  https://github.com/NuLink-network
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
