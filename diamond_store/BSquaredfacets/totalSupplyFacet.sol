/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/BsquaredNetwork
 * Website: https://buzz.bsquared.network/?utm_source=icodrops
 * Medium: https://medium.com/@bsquarednetwork
 * Discord: https://discord.com/invite/bsquarednetwork
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