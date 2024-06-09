/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/zkPass
    // Website: https://zkpass.org/
    // Discord: https://discord.com/invite/zkpass
    // Medium:  https://medium.com/zkpass

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
