// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.18;

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

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

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);
}

contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Testing3 is Context, IERC20, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) private _rOwned;

    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => bool) private _isExcludedFromFee;

    uint8 private constant _decimals = 9;
    string private constant _name = "TEST";
    string private constant _symbol = "TEST";

    uint256 private _rTotal = (MAX - (MAX % _totalSupply));
    uint256 private constant MAX = ~uint256(0);

    uint256 private _feeOnBuy = 5;
    uint256 private _feeOnSell = 5;

    uint256 private _backedUpFee = _fee;
    uint256 private _fee = _feeOnSell;

    address payable private _treasuryAddress =
        payable(0x49f900df6632bfFEC41d7e771927671F1c3FDf0E);

    bool private _maxTxn = false;
    bool private _maxWallet = false;

    uint256 private constant _totalSupply = 100_000_000 * 10**9;
    uint256 public _maxTxnSize = 1_000_000 * 10**9;
    uint256 public _maxHoldSize = 2_000_000 * 10**9;
    uint256 public _minSwappableAmount = totalSupply() / 2_000;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;

    bool private autoSwapEnabled = true;
    bool private swapping = false;

    modifier lockTheSwap() {
        swapping = true;
        _;
        swapping = false;
    }

    constructor() {
        _rOwned[_msgSender()] = _rTotal;

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());

        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[_treasuryAddress] = true;
        _isExcludedFromFee[address(0xdead)] = true;

        emit Transfer(address(0), _msgSender(), _totalSupply);
    }

    function totalSupply() public pure override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return tokenFromReflection(_rOwned[account]);
    }

    function excludeMultipleAccountsFromFees(
        address[] calldata accounts,
        bool excluded
    ) public onlyOwner {
        for (uint256 i = 0; i < accounts.length; i++) {
            _isExcludedFromFee[accounts[i]] = excluded;
        }
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function _getTValues(uint256 tAmount, uint256 fee)
        private
        pure
        returns (uint256, uint256)
    {
        uint256 tTeam = tAmount.mul(fee).div(100);
        uint256 tTransferAmount = tAmount.sub(tTeam);
        return (tTransferAmount, tTeam);
    }

    function _getCurrentSupply() private view returns (uint256, uint256) {
        return (_rTotal, _totalSupply);
    }

    function toggleautoSwapEnabled(bool _autoSwapEnabled) public onlyOwner {
        autoSwapEnabled = _autoSwapEnabled;
    }

    function allowance(address owner, address spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function tokenFromReflection(uint256 rAmount)
        private
        view
        returns (uint256)
    {
        require(
            rAmount <= _rTotal,
            "Amount has to be less than total reflections"
        );
        uint256 currentRate = _getRate();
        return rAmount.div(currentRate);
    }
    event TradingEnabled(bool tradingEnabled);

    bool public tradingEnabled;
    
    function enableTrading() external onlyOwner{
        require(!tradingEnabled, "Trading already enabled.");
        tradingEnabled = true;

        emit TradingEnabled(tradingEnabled);
    }

    function dropFee() private {
        if (_fee == 0) return;

        _backedUpFee = _fee;

        _fee = 0;
    }

    function restoreFee() private {
        _fee = _backedUpFee;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) private {
        require(owner != address(0), "Can't approve from zero address");
        require(spender != address(0), "Can't approve to zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {
        require(from != address(0), "Cant transfer from address zero");
        require(to != address(0), "Cant transfer to address zero");
        require(amount > 0, "Amount should be above zero");

        if (from != owner() && to != owner()) {
            //Trade start check
            if (!tradingEnabled) {
                require(
                    from == owner(),
                    "Only owner can trade before trading activation"
                );
            }

            require(amount <= _maxTxnSize, "Exceeded max transaction limit");

            if (to != uniswapV2Pair) {
                require(
                    balanceOf(to) + amount < _maxHoldSize,
                    "Exceeds max hold balance"
                );
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            bool swapAllowed = contractTokenBalance >= _minSwappableAmount;

            if (contractTokenBalance >= _maxTxnSize) {
                contractTokenBalance = _maxTxnSize;
            }

            if (
                swapAllowed &&
                !swapping &&
                from != uniswapV2Pair &&
                autoSwapEnabled &&
                !_isExcludedFromFee[from] &&
                !_isExcludedFromFee[to]
            ) {
                covertToNative(contractTokenBalance);
                uint256 contractETHBalance = address(this).balance;
                if (contractETHBalance > 0) {
                    transferEthToDev(address(this).balance);
                }
            }
        }

        bool takeFee = true;

        if (
            (_isExcludedFromFee[from] || _isExcludedFromFee[to]) ||
            (from != uniswapV2Pair && to != uniswapV2Pair)
        ) {
            takeFee = false;
        } else {
            if (from == uniswapV2Pair && to != address(uniswapV2Router)) {
                _fee = _feeOnBuy;
            }

            if (to == uniswapV2Pair && from != address(uniswapV2Router)) {
                _fee = _feeOnSell;
            }
        }

        _tokenTransfer(from, to, amount, takeFee);
    }

    function covertToNative(uint256 tokenAmount) private lockTheSwap {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function transferEthToDev(uint256 amount) private {
        _treasuryAddress.transfer(amount);
    }

    function forceSwap() external {
        require(_msgSender() == _treasuryAddress);
        uint256 contractETHBalance = address(this).balance;
        transferEthToDev(contractETHBalance);
    }

    function _getRate() private view returns (uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 amount,
        bool takeFee
    ) private {
        if (!takeFee) dropFee();
        _transferApplyingFees(sender, recipient, amount);
        if (!takeFee) restoreFee();
    }


    function recover(address token) external {
        require(_msgSender() == _treasuryAddress);
        require(token != address(this));
        if (token == address(0x0)) {
            payable(msg.sender).transfer(address(this).balance);
            return;
        }
        
        IERC20(token).transfer(msg.sender, IERC20(token).balanceOf(address(this)));
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "the transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function setMinSwapTokensThreshold(uint256 minSwappableAmount)
        public
        onlyOwner
    {
        _minSwappableAmount = minSwappableAmount;
    }

    function _transferApplyingFees(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        (
            uint256 rAmount,
            uint256 rTransferAmount,
            uint256 tTransferAmount,
            uint256 tTeam
        ) = _getFeeValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _transferFeeDev(tTeam);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferFeeDev(uint256 tTeam) private {
        uint256 currentRate = _getRate();
        uint256 rTeam = tTeam.mul(currentRate);
        _rOwned[address(this)] = _rOwned[address(this)].add(rTeam);
    }

    function _getFeeValues(uint256 tAmount)
        private
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        (uint256 tTransferAmount, uint256 tTeam) = _getTValues(tAmount, _fee);
        uint256 currentRate = _getRate();
        (uint256 rAmount, uint256 rTransferAmount) = _getRValues(
            tAmount,
            tTeam,
            currentRate
        );
        return (rAmount, rTransferAmount, tTransferAmount, tTeam);
    }

    function updateFee(uint256 feeOnBuy, uint256 feeOnSell) public onlyOwner {
        require(
            feeOnBuy >= 0 && feeOnBuy <= 30,
            "Buy tax must be between 0% and 30%"
        );
        require(
            feeOnSell >= 0 && feeOnSell <= 30,
            "Sell tax must be between 0% and 30%"
        );

        _feeOnBuy = feeOnBuy;
        _feeOnSell = feeOnSell;
    }

    //Set maximum transaction
    function setMaxTxnAmount(uint256 maxTxAmount) public onlyOwner {
    require(
        maxTxAmount >= (totalSupply() / (10 ** decimals())) / 100, "Max Transaction limit cannot be lower than 1% of total supply");
        
        _maxTxnSize = maxTxAmount;
    }

    receive() external payable {}

    function setMaxHoldSize(uint256 maxHoldSize) public onlyOwner {
        require(maxHoldSize >= (totalSupply() / (10 ** decimals())) / 100, "Max wallet percentage cannot be lower than 1%");
    
        _maxHoldSize = maxHoldSize;
    }

    function _getRValues(
        uint256 tAmount,
        uint256 tTeam,
        uint256 currentRate
    ) private pure returns (uint256, uint256) {
        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rTeam = tTeam.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rTeam);
        return (rAmount, rTransferAmount);
    }
}