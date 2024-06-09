/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/MindNetwork_xyz
    // Twitter: https://twitter.com/mindnetwork_xyz
    // Website: https://mindnetwork.xyz/
    // Discord: https://discord.com/invite/UYj94MJdGJ
    // Medium:  https://mindnetwork.medium.com/

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
