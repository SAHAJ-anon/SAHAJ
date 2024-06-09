/*
 * SPDX-License-Identifier: MIT
 * Website: https://havacoin.xyz/
 * Twitter: https://twitter.com/Hava_Coin
 * Telegram Group: https://t.me/HavaCoinArmy
 * Telegram Channel:https://t.me/HavaCoinZone
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
