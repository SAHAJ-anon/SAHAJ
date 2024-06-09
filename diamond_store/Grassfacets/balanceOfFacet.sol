/*  
   * SPDX-License-Identifier: MIT
   * Twitter: https://twitter.com/getgrass_io
   * Website: https://www.getgrass.io/
   * Discord Chat: https://discord.gg/8NxzRj9ayN
   
*/
pragma solidity ^0.8.25;

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
