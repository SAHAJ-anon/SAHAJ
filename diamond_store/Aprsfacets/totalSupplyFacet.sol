/*
 * SPDX-License-Identifier: MIT
 * Discord: https://discord.com/invite/apeiron-doodaria
 * Twitter: https://twitter.com/ApeironNFT
 * Website: https://apeironnft.com/
 */
pragma solidity ^0.8.22;

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
