// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// WEB      http://trybmp.com
// TG     https://t.me/bmpportal
// X        https://twitter.com/bmp_erc

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
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

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }

}

contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}

contract BMP is Context, IERC20, Ownable {
    using SafeMath for uint256;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _isExcludedFromFee;
    mapping(address => uint256) public dividendsOwed;
    mapping(address => uint256) public tokenBalance;

    address payable private _marketingPool = payable(0x4D7726A974630759C5CE1f8bC6064bbE879C2c85);
    address payable private _developmentPool = payable(0x0F0C5eC464467029b97464202E9E9e763197920b);
    address payable private _treasuryPool = payable(0x7c4a2c63440A71475B8890c72E50CD982CC93E74);
    
    address private _vestingContract;

    uint256 public minimumThresholdForDividends = 300000 * 10**8;
    uint256 public taxRate = 5; 

    address payable private _feeAddress;
    uint256 firstBlock;

    uint256 private _initialBuyTax=20;
    uint256 private _initialSellTax=20;
    uint256 private _finalBuyTax=5;
    uint256 private _finalSellTax=5;
    uint256 private _reduceBuyTaxAt=20;
    uint256 private _reduceSellTaxAt=50;
    uint256 private _preventSwapBefore=30;
    uint256 private _buyCount=0;

    uint8 private constant _decimals = 10;
    uint256 private constant _tTotal = 15_000_000 * 10**_decimals;
    
    string private constant _name = unicode"BMP";
    string private constant _symbol = unicode"BMP";

    uint256 public _maxTxAmount =   98_000 * 10**_decimals;
    uint256 public _maxWalletSize = 98_000 * 10**_decimals;
    uint256 public _taxSwapThreshold= 15_000 * 10**_decimals;
    uint256 public _maxTaxSwap= 49_000 * 10**_decimals;

    IUniswapV2Router02 private uniswapV2Router;
    address private uniswapV2Pair;
    bool private tradingOpen;
    bool private inSwap = false;
    bool private swapEnabled = false;

    event DividendsAccrued(address indexed holder, uint256 amount);
    event MaxTxAmountUpdated(uint _maxTxAmount);
    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor () {

        _feeAddress = payable(_msgSender());
        _balances[_msgSender()] = _tTotal;
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[_feeAddress] = true;
        
        emit Transfer(address(0), _msgSender(), _tTotal);
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

    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

function _transfer(address from, address to, uint256 amount) private {
    require(from != address(0), "ERC20: transfer from the zero address");
    require(to != address(0), "ERC20: transfer to the zero address");
    require(amount > 0, "Transfer amount must be greater than zero");
    uint256 taxAmount = 0;
        if (from != owner() && to != owner()) {
            taxAmount = amount.mul((_buyCount>_reduceBuyTaxAt)?_finalBuyTax:_initialBuyTax).div(100);

            if (from == uniswapV2Pair && to != address(uniswapV2Router) && ! _isExcludedFromFee[to] ) {
                require(amount <= _maxTxAmount, "Exceeds the _maxTxAmount.");
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");

                if (firstBlock + 3  > block.number) {
                    require(!isContract(to));
                }
                _buyCount++;
            }

            if (to != uniswapV2Pair && ! _isExcludedFromFee[to]) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");
            }

            if(to == uniswapV2Pair && from!= address(this) ){
                taxAmount = amount.mul((_buyCount>_reduceSellTaxAt)?_finalSellTax:_initialSellTax).div(100);
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            if (!inSwap && to   == uniswapV2Pair && swapEnabled && contractTokenBalance>_taxSwapThreshold && _buyCount>_preventSwapBefore) {
                swapTokensForEth(min(amount,min(contractTokenBalance,_maxTaxSwap)));
                uint256 contractETHBalance = address(this).balance;
                if(contractETHBalance > 0) {
                    sendETHToFee(address(this).balance);
                }
            }
        }

         if (taxAmount > 0) {
        _balances[address(this)] = _balances[address(this)].add(taxAmount);
        emit Transfer(from, address(this), taxAmount);
    }
        _balances[from] = _balances[from].sub(amount);
        _balances[to] = _balances[to].add(amount.sub(taxAmount));
        emit Transfer(from, to, amount.sub(taxAmount));

    }

    function min(uint256 a, uint256 b) private pure returns (uint256){
      return (a>b)?b:a;
    }

    function isContract(address account) private view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
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

    function calculateDividendAmount(address holder, uint256 amount) private view returns (uint256) {
        uint256 balance = tokenBalance[holder];
        uint256 magnifier = getMagnifier(balance);
        uint256 dividendAmount = SafeMath.mul(amount, balance);
        dividendAmount = SafeMath.div(dividendAmount, 15_000_000 * 10**_decimals);
        dividendAmount = SafeMath.mul(dividendAmount, magnifier);
        dividendAmount = SafeMath.div(dividendAmount, 100);
        return dividendAmount;
        }

    function getMagnifier(uint256 balance) private pure returns (uint256) {
        uint256 magnifier = 100; // Base magnifier
        if (balance >= 105000 * 10**8) { // 0.7% of total supply
            magnifier = 135;
        } else if (balance >= 75000 * 10**8) { // 0.5% of total supply
            magnifier = 125;
        } else if (balance >= 45000 * 10**8) { // 0.3% of total supply
            magnifier = 115;
        }
        return magnifier;
    }

    function getDividendsOwedForHolder(address holder) private view returns (uint256) {
        require(_balances[holder] > 0, "Backend API for Dividends");
        return dividendsOwed[holder];
    }

    function withdrawStuckETH() external onlyOwner {
        require(address(this).balance > 0, "No stuck ETH to withdraw");
        
        uint256 amount = address(this).balance;
        payable(owner()).transfer(amount);
    }

    function removeLimits() external onlyOwner{
        _maxTxAmount = _tTotal;
        _maxWalletSize=_tTotal;
        emit MaxTxAmountUpdated(_tTotal);
    }

    function sendETHToFee(uint256 amount) private {
        uint256 marketingShare = amount.mul(2).div(5);
        uint256 developmentShare = amount.mul(2).div(5);
        uint256 treasuryShare = amount.sub(marketingShare).sub(developmentShare);

        _marketingPool.transfer(marketingShare);
        _developmentPool.transfer(developmentShare);
        _treasuryPool.transfer(treasuryShare);
    }

     function initializeAllocations(uint256 developmentAllocation, uint256 marketingAllocation, uint256 treasuryAllocation) external onlyOwner {
        require(!tradingOpen, "Trading is already open");
        require(developmentAllocation > 0 && marketingAllocation > 0 && treasuryAllocation > 0, "Allocations must be greater than zero");
        require(developmentAllocation + marketingAllocation + treasuryAllocation <= _balances[_msgSender()], "Insufficient balance for allocations");

        _allocateTokens(_developmentPool, developmentAllocation);
        _allocateTokens(_marketingPool, marketingAllocation);
        _allocateTokens(_treasuryPool, treasuryAllocation);
    }

    function _allocateTokens(address recipient, uint256 amount) private {
        _balances[_msgSender()] = _balances[_msgSender()].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(_msgSender(), recipient, amount);

    }

     function setVestingContract(address vestingContract) external onlyOwner {
        require(!tradingOpen, "Trading is already open");
        _vestingContract = vestingContract;
    }

    function allocateVestingTokens(uint256 vestingAllocation) external onlyOwner {
        require(!tradingOpen, "Trading is already open");
        require(_vestingContract != address(0), "Vesting contract address not set");
        require(vestingAllocation > 0, "Vesting allocation must be greater than zero");
        require(vestingAllocation <= _balances[_msgSender()], "Insufficient balance for vesting allocation");

        _allocateTokensWithoutRestrictions(_vestingContract, vestingAllocation);
    }

    function _allocateTokensWithoutRestrictions(address recipient, uint256 amount) private {
        _balances[_msgSender()] = _balances[_msgSender()].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(_msgSender(), recipient, amount);
    }
    
    function openTrading() external onlyOwner() {
        require(!tradingOpen,"trading is already open");
        uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        _approve(address(this), address(uniswapV2Router), _tTotal);
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());
        uniswapV2Router.addLiquidityETH{value: address(this).balance}(address(this),balanceOf(address(this)),0,0,owner(),block.timestamp);
        IERC20(uniswapV2Pair).approve(address(uniswapV2Router), type(uint).max);
        swapEnabled = true;
        tradingOpen = true;
        firstBlock = block.number;
    }

receive() external payable {}
}