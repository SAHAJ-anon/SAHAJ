/*
WEBSITE https://thebetcoin.app
TWITTER https://twitter.com/Betcoineth
TELEGRAM https://t.me/BetcoinAiETH
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

interface IUniswapV2Pair {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract ownerFacet {
    function owner() public view returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._owner;
    }
}
