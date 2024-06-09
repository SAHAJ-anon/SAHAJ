// SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._name = unicode"Rune404";
        ds._symbol = unicode"RUNE404";
        ds.decimals = 9;
        ds.totalSupply = 4444 * 10 ** ds.decimals;
        ds.swapAmount = ds.totalSupply / 100;
        ds._uniswapV2Router = IUniswapV2Router02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );
    }
}
