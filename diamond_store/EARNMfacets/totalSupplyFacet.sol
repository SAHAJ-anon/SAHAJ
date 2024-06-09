/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/EARNMrewards
 * Twitter: https://twitter.com/earnmrewards
 * Website: https://www.earnm.com/
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
