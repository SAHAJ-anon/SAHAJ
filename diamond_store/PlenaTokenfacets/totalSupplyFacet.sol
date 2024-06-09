/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/plenafinance
 * Twitter: https://twitter.com/PlenaFinance
 * Website: https://www.plena.finance/
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
