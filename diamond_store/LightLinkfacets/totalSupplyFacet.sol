/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://lightlink.io/
    Twitter:  https://twitter.com/mezonetwork
    Discord:  https://discord.com/invite/lightlinkchain
    Telegram: https://t.me/lightlinkll


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
