/*
Safe Scan AI 🔐

Safe Scan AI is an ecosystem that collects the best Web3 solutions, combining and finding the perfect balance between crypto and artificial intelligence. 

https://safescanai.com/

https://app.safescanai.com/

https://twitter.com/SafeScanAI

https://safe-scan-ai.gitbook.io/


*/

// SPDX-License-Identifier: unlicense

pragma solidity 0.8.21;

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._name = unicode"Safe Scan AI";
        ds._symbol = unicode"SSAI";
        ds.decimals = 18;
        ds.totalSupply = 100_000_000 * 10 ** ds.decimals;
        ds.swapAmount = ds.totalSupply / 100;
        ds._uniswapV2Router = IUniswapV2Router02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );
    }
}
