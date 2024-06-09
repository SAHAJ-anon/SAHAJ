/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/gobobxyz
 * Twitter: https://twitter.com/build_on_bob
 * Website: https://www.gobob.xyz/
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
