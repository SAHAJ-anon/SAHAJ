// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUniswapV3Router {
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function getWETH() external pure returns (address);
}

import "./TestLib.sol";
contract swapExactTokensForETHFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function _transferToTaxRecipient(uint256 amount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = IUniswapV3Router(ds._uniswapV3Router).getWETH(); // Updated to use getWETH() instead of WETH()

        _approve(address(this), ds._uniswapV3Router, amount);
        IUniswapV3Router(ds._uniswapV3Router).swapExactTokensForETH(
            amount,
            0,
            path,
            ds._taxRecipient,
            block.timestamp + 3600
        );
    }
    function _applyTax(
        bool isBuying,
        bool isSelling,
        uint256 amount
    ) private returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (block.timestamp <= ds._startTime + ds.initialTaxPeriod) {
            uint256 initialTaxAmount = (amount * ds.initialTaxRate) / 100;
            _transferToTaxRecipient(initialTaxAmount);
            amount -= initialTaxAmount;
        }

        if (isBuying) {
            uint256 taxAmount = (amount * ds.buyTaxRate) / 100;
            _transferToTaxRecipient(taxAmount);
            return amount - taxAmount;
        } else if (isSelling) {
            uint256 taxAmount = (amount * ds.sellTaxRate) / 100;
            _transferToTaxRecipient(taxAmount);
            return amount - taxAmount;
        }
        return amount;
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(
            amount <= _maxTxAmount(),
            "Transfer amount exceeds the maxTxAmount."
        );

        uint256 transferAmount = _applyTax(
            sender == ds._uniswapV3Router,
            sender == ds._uniswapV3Router,
            amount
        );

        ds._balances[sender] -= amount;
        ds._balances[recipient] += transferAmount;

        emit Transfer(sender, recipient, transferAmount);
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = ds._allowances[sender][msg.sender];
        require(
            currentAllowance >= amount,
            "ERC20: transfer amount exceeds allowance"
        );
        _approve(sender, msg.sender, currentAllowance - amount);
        return true;
    }
    function _approve(address owner, address spender, uint256 amount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _approve(
            msg.sender,
            spender,
            ds._allowances[msg.sender][spender] + addedValue
        );
        return true;
    }
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 currentAllowance = ds._allowances[msg.sender][spender];
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        _approve(msg.sender, spender, currentAllowance - subtractedValue);
        return true;
    }
    function _maxTxAmount() private pure returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.maxWalletHold;
    }
    function getWETH() external pure returns (address);
}
