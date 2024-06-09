/*
 * SPDX-License-Identifier: MIT
 * Website: https://hedgehog.markets/#/?utm_source=icodrops
 * Twitter: https://twitter.com/HedgehogMarket
 * Telegram: https://t.me/hedgehogmarkets
 * discord: https://discord.gg/vt8Dw5SN58
 */
pragma solidity ^0.8.19;

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
