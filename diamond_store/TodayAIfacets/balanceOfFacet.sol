/**

*/

/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/todaythegame
    // Website: https://side.xyz/today / https://www.todaythegame.com/
    // Discord: https://discord.com/invite/todaythegame
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
