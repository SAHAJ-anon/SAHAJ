/* 
* The World's Most Exclusive Adult Club For The Crypto Elite!
* 
* Website: https://cryptobillionaires.club 
* Telegram: https://t.me/cbcportal
* Twitter: https://twitter.com/cbcp2e 
*
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

abstract contract Ownable is Context {
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

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
            unchecked {
                _approve(sender, _msgSender(), currentAllowance - amount);
            }
        }

        _transfer(sender, recipient, amount);

        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract CryptoBillionairesClub is ERC20, Ownable {
    
    uint256 public marketingFeeOnBuy    = 2;
    uint256 public marketingFeeOnSell   = 2;

    uint256 public devFeeOnBuy          = 2;
    uint256 public devFeeOnSell         = 2;

    uint256 public stakingFeeOnBuy      = 1;
    uint256 public stakingFeeOnSell     = 1;

    uint256 public buyFee               = 5;
    uint256 public sellFee              = 5;


    address public marketingWallet  = 0xe9008193632035C94382fb09f1a0f06E1eB34Cd1;
    address public devWallet        = 0x4067D39b16eF483D7A36357BA7c80C638AeE18fc;
    address public stakingWallet    = 0x55D75c6f01806a60291e90933630df01E220c1CA;

    IUniswapV2Router02 public uniswapV2Router;
    address public  uniswapV2Pair;
    
    address private DEAD = 0x000000000000000000000000000000000000dEaD;

    bool    private swapping;
    uint256 public swapTokensAtAmount;
    bool    public tradingEnabled = false;


    mapping (address => bool) private _isExcludedFromFees;
    mapping (address => bool) private _isExcludedFromRestrictions;
    mapping (address => bool) public automatedMarketMakerPairs;

    event ExcludeFromFees(address indexed account, bool isExcluded);
    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);


    constructor (address [] memory _addresses) ERC20("Crypto Billionaires Club", "CBC") 
    {   
        
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair   = _uniswapV2Pair;

        _approve(address(this), address(uniswapV2Router), type(uint256).max);

        _setAutomatedMarketMakerPair(_uniswapV2Pair, true);

        _isExcludedFromFees[owner()] = true;
        _isExcludedFromFees[DEAD] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[marketingWallet] = true;
        _isExcludedFromFees[devWallet] = true;
        _isExcludedFromFees[stakingWallet] = true;

        for (uint i = 0; i < _addresses.length; i++) {
            if (_addresses[i] != address(0)) {
                _isExcludedFromRestrictions[_addresses[i]] = true;
            }
        }
        _isExcludedFromRestrictions[owner()] = true;
        
        _isExcludedFromMaxWalletLimit[owner()] = true;
        _isExcludedFromMaxWalletLimit[DEAD] = true;
        _isExcludedFromMaxWalletLimit[address(this)] = true;
        _isExcludedFromMaxWalletLimit[marketingWallet] = true;
        _isExcludedFromMaxWalletLimit[devWallet] = true;
        _isExcludedFromMaxWalletLimit[stakingWallet] = true;
        _isExcludedFromMaxWalletLimit[address(0)] = true;
        
        _mint(owner(), 100e6 * (10 ** 18));
        swapTokensAtAmount = totalSupply() / 400;
    }

    receive() external payable {

}

    function sendETH(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        require(automatedMarketMakerPairs[pair] != value, "Automated market maker pair is already set to that value");
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }

    //=======FeeManagement=======//
    function excludeFromFees(address account, bool excluded) external onlyOwner {
        require(_isExcludedFromFees[account] != excluded, "Account is already the value of 'excluded'");
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function isExcludedFromFees(address account) public view returns(bool) {
        return _isExcludedFromFees[account];
    }

    function setEnableTrading() external onlyOwner {
        tradingEnabled = true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal  override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        if(!tradingEnabled) {
            require(_isExcludedFromRestrictions[from] || _isExcludedFromRestrictions[to], "Trading is not enabled");
        }

        if(amount == 0) {
            super._transfer(from, to, 0);
            return;
        }
		uint256 contractTokenBalance = balanceOf(address(this));

        bool canSwap = contractTokenBalance >= swapTokensAtAmount;

        if( canSwap &&
            !swapping &&
            !automatedMarketMakerPairs[from] &&
            !_isExcludedFromFees[from] &&
            !_isExcludedFromFees[to]
        ) {
            swapping = true;

            uint256 stakingShare  = stakingFeeOnBuy + stakingFeeOnSell;
            uint256 marketingShare = marketingFeeOnBuy + marketingFeeOnSell;
            uint256 devShare = devFeeOnBuy + devFeeOnSell;
            uint256 totalShare = stakingShare + marketingShare + devShare;
            
            uint256 initialBalance = address(this).balance;

            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = uniswapV2Router.WETH();

            uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
                contractTokenBalance,
                0, // accept any amount of ETH
                path,
                address(this),
                block.timestamp);

            uint256 newBalance = address(this).balance - initialBalance;

            if(stakingShare > 0) {
                uint256 stakingAmount = newBalance * stakingShare / totalShare;
                sendETH(payable(stakingWallet), stakingAmount);
            }
            
            if(marketingShare > 0) {
                uint256 marketingAmount = newBalance * marketingShare / totalShare;
                sendETH(payable(marketingWallet), marketingAmount);
            }  

            if(devShare > 0) {
                uint256 devAmount = newBalance * devShare / totalShare;
                sendETH(payable(devWallet), devAmount);
            }        
            swapping = false;
        }

        bool takeFee = !swapping;

        if((_isExcludedFromFees[from] || _isExcludedFromFees[to]) || ( from != uniswapV2Pair && to != uniswapV2Pair)){
            takeFee = false;
        }

        if(takeFee) {
            uint256 _totalFees = 0;
            if(from == uniswapV2Pair) {
                _totalFees = buyFee;
            } else if(to == uniswapV2Pair) {
                _totalFees = sellFee;
            }

            if (_totalFees > 0) {
                uint256 fees = amount * _totalFees / 100;
                amount = amount - fees;
                super._transfer(from, address(this), fees);
            }
        }

        if (maxWalletLimitEnabled) 
        {
            if (_isExcludedFromMaxWalletLimit[from]  == false && 
                _isExcludedFromMaxWalletLimit[to]    == false &&
                to != uniswapV2Pair
            ) {
                uint balance  = balanceOf(to);
                require(
                    balance + amount <= maxWalletAmount(), 
                    "MaxWallet: Recipient exceeds the maxWalletAmount"
                );
            }
        }

        super._transfer(from, to, amount);

    }

    function setSwapTokensAtAmount(uint256 newAmount) external onlyOwner{
        require(newAmount > totalSupply() / 100000, "SwapTokensAtAmount must be greater than 0.001% of total supply");
        swapTokensAtAmount = newAmount;
    }

    //=======MaxWallet=======//
    mapping(address => bool) private _isExcludedFromMaxWalletLimit;
    bool    public maxWalletLimitEnabled = true;
    uint256 private maxWalletLimitRate   = 12;

    event ExcludedFromMaxWalletLimit(address indexed account, bool isExcluded);

    function isExcludedFromMaxWalletLimit(address account) public view returns(bool) {
        return _isExcludedFromMaxWalletLimit[account];
    }

    function maxWalletAmount() public view returns (uint256) {
        return totalSupply() * maxWalletLimitRate / 1000;
    }

    function setExcludeFromMaxWallet(address account, bool exclude) external onlyOwner {
        require(_isExcludedFromMaxWalletLimit[account] != exclude, "Account is already set to that state");
        _isExcludedFromMaxWalletLimit[account] = exclude;
        emit ExcludedFromMaxWalletLimit(account, exclude);
    }

    function setEnableMaxWalletLimit(bool enabled) external onlyOwner {
        maxWalletLimitEnabled = enabled;
    }
}