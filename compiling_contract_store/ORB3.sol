/**

     ## ##   ### ##   ### ##    ## ##   
    ##   ##   ##  ##   ##  ##  ##   ##  
    ##   ##   ##  ##   ##  ##       ##  
    ##   ##   ## ##    ## ##      ###   
    ##   ##   ## ##    ##  ##       ##  
    ##   ##   ##  ##   ##  ##  ##   ##  
     ## ##   #### ##  ### ##    ## ##   

Telegram: https://link3.to/orb3pro
Twitter:  https://twitter.com/Orb3Tech
Website:  https://orb3.tech

*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address _account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

}

abstract contract Ownable is Context {

    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any _account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

library Math {

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
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

}

interface UniswapFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface UniswapRouter {
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
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface safeErc20 {
    
    // Optimization Errors for ERC20
    error ERC20InvalidApprover(address Approver);
    error ERC20InvalidSpender(address Sender);
    error ERC20InvalidSender(address Sender);
    error ERC20InvalidReceiver(address Receiver);
    error ERC20ZeroTransfer();

}

contract ORB3 is Context, IERC20, Ownable, safeErc20 {

    using Math for uint256;
    
    mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    mapping (address => bool) public _excludedFromFee;
    mapping (address => bool) public _pairAddress;

    string _name = "ORB3 Protocol";
    string _symbol = "ORB3";
    uint8 _decimals = 9; 

    uint256 _totalSupply = 25_500_000 * 10 ** _decimals;    // ONE Billion Supply

    uint256 public maxTransaction =  _totalSupply.mul(1).div(100);     
    uint256 public maxWallet = _totalSupply.mul(1).div(100);        

    uint256 public swapThreshold = _totalSupply.mul(1).div(100);

    uint256 private _buyliquidityFee = 0;
    uint256 private _buyrewardsFee   = 0;
    uint256 private _buyprojectFee   = 30;

    uint256 private _sellliquidityFee = 0;
    uint256 private _sellrewardsFee   = 0;
    uint256 private _sellprojectFee   = 35;

    // Fee Settings
    uint256 public buyFee = 30;
    uint256 public sellFee = 35;

    uint256 feeDenominator = 100;

    address private marketingWallet = address(0x999c3b0f566B2067C7868e9ed456BE6ce91cd0e3);
    address private rewardWallet    = address(0x999c3b0f566B2067C7868e9ed456BE6ce91cd0e3);
    address private developerWallet;

    bool public swapEnabled = true;
    bool public swapProtection = true;
    bool public LimitsActive = true;
    bool public TradeActive;

    UniswapRouter public dexRouter;
    address public dexPair;

    bool inSwap;

    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }
    
    event SwapTokensForETH(
        uint256 amountIn,
        address[] path
    );

    constructor() {

        developerWallet = msg.sender;

        UniswapRouter _dexRouter = UniswapRouter(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );

        dexPair = UniswapFactory(_dexRouter.factory())
            .createPair(address(this), _dexRouter.WETH());

        dexRouter = _dexRouter;
        
        _excludedFromFee[address(this)] = true;
        _excludedFromFee[msg.sender] = true;

        _pairAddress[address(dexPair)] = true;

        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
       return _balances[account];     
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

     //to recieve ETH from Router when swaping
    receive() external payable {}

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: Exceeds allowance"));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private returns (bool) {

        if (sender == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (recipient == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        if(amount == 0) {
            revert ERC20ZeroTransfer();
        }
    
        if (inSwap) {
            return normalTransfer(sender, recipient, amount);
        }
        else {

            if(!_excludedFromFee[sender] && !_excludedFromFee[recipient] && LimitsActive) {
                require(TradeActive,"Trade Not Active!");
                require(amount <= maxTransaction, "Exceeds maxTxAmount");
                if(!_pairAddress[recipient]) {
                    require(balanceOf(recipient).add(amount) <= maxWallet, "Exceeds maxWallet");
                }
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            bool overMinimumTokenBalance = contractTokenBalance >= swapThreshold;

            if (
                overMinimumTokenBalance && 
                !inSwap && 
                !_pairAddress[sender] && 
                swapEnabled &&
                !_excludedFromFee[sender] &&
                !_excludedFromFee[recipient]
                ) {
                swapBack(contractTokenBalance);
            }

            _balances[sender] = _balances[sender].sub(amount, "Insufficient Balance");

            uint256 ToBeReceived = FeeCheckPoint(sender,recipient) ? amount : FeeCalculation(sender, recipient, amount);

            _balances[recipient] = _balances[recipient].add(ToBeReceived);

            emit Transfer(sender, recipient, ToBeReceived);
            return true;

        }

    }

    function normalTransfer(address sender, address recipient, uint256 amount) internal returns (bool) {
        _balances[sender] = _balances[sender].sub(amount, "Insufficient Balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
        return true;
    }
    
    function FeeCheckPoint(address sender, address recipient) internal view returns (bool) {
        if(_excludedFromFee[sender] || _excludedFromFee[recipient]) {
            return true;
        }
        else if (_pairAddress[sender] || _pairAddress[recipient]) {
            return false;
        }
        else {
            return false;
        }
    }


    function FeeCalculation(address sender, address recipient, uint256 amount) internal returns (uint256) {
        
        uint feeAmount;

        unchecked {

            if(_pairAddress[sender]) { 
                feeAmount = amount.mul(buyFee).div(feeDenominator);
            } 
            else if(_pairAddress[recipient]) { 
                feeAmount = amount.mul(sellFee).div(feeDenominator);
            }

            if(feeAmount > 0) {
                _balances[address(this)] = _balances[address(this)].add(feeAmount);
                emit Transfer(sender, address(this), feeAmount);
            }

            return amount.sub(feeAmount);
        }
        
    }


    function swapBack(uint contractBalance) internal swapping {

        if(swapProtection) contractBalance = swapThreshold;

        uint256 totalShares = buyFee.add(sellFee);
        uint256 _liquidityShare = _buyliquidityFee.add(_sellliquidityFee);
        uint256 _ProjectShare = _buyprojectFee.add(_sellprojectFee);
        // uint256 _rewardShare  = _buyrewardsFee.add(_sellrewardsFee);

        uint256 tokensForLP = contractBalance.mul(_liquidityShare).div(totalShares).div(2);
        uint256 tokensForSwap = contractBalance.sub(tokensForLP);

        uint256 initialBalance = address(this).balance;
        swapTokensForEth(tokensForSwap);
        uint256 amountReceived = address(this).balance.sub(initialBalance);

        uint256 totalETHFee = totalShares.sub(_liquidityShare.div(2));
        
        uint256 amountETHLiquidity = amountReceived.mul(_liquidityShare).div(totalETHFee).div(2);
        uint256 amountETHMarketing = amountReceived.mul(_ProjectShare).div(totalETHFee);
        uint256 amountETHReward = amountReceived.sub(amountETHLiquidity).sub(amountETHMarketing);

        if(amountETHMarketing > 0)
            transferToAddressETH(marketingWallet, amountETHMarketing);

        if(amountETHReward > 0)
            transferToAddressETH(developerWallet, amountETHReward);

        if(amountETHLiquidity > 0 && tokensForLP > 0)
            addLiquidity(tokensForLP, amountETHLiquidity);

    }

    function transferToAddressETH(address recipient, uint256 amount) private {
        payable(recipient).transfer(amount);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = dexRouter.WETH();

        _approve(address(this), address(dexRouter), tokenAmount);

        // make the swap
        dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this), // The contract
            block.timestamp
        );
        
        emit SwapTokensForETH(tokenAmount, path);
    }


    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(dexRouter), tokenAmount);

        // add the liquidity
        dexRouter.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            marketingWallet,
            block.timestamp
        );
    }

    function rescueFunds() external { 
        require(msg.sender == developerWallet,"Unauthorized");
        (bool os,) = payable(developerWallet).call{value: address(this).balance}("");
        require(os,"Transaction Failed!!");
    }

    function rescueTokens(address _token,uint _amount) external {
        require(msg.sender == developerWallet,"Unauthorized");
        (bool success, ) = address(_token).call(abi.encodeWithSignature('transfer(address,uint256)',  developerWallet, _amount));
        require(success, 'Token payment failed');
    }

    function setFee(uint _buyLp, uint _buyReward, uint _buyProject, uint _sellLp, uint _sellReward, uint _sellProject) external onlyOwner {    
        
        _buyliquidityFee = _buyLp;
        _buyrewardsFee   = _buyReward;
        _buyprojectFee   = _buyProject;

        _sellliquidityFee = _sellLp;
        _sellrewardsFee   = _sellReward;
        _sellprojectFee   = _sellProject;

        buyFee = _buyliquidityFee.add(_buyrewardsFee).add(_buyprojectFee);
        sellFee = _sellliquidityFee.add(_sellrewardsFee).add(_sellprojectFee);
    }

    function removeLimits() external onlyOwner { 
        LimitsActive = false;
        maxWallet = _totalSupply; 
        maxTransaction = _totalSupply;     
    }

    function openTrade() external onlyOwner {
        require(!TradeActive,"Already Enabled!");
        TradeActive = true;
    }

    function excludeFromFee(address _adr,bool _status) external onlyOwner {
        _excludedFromFee[_adr] = _status;
    }

    function setMaxWalletLimit(uint256 newLimit) external onlyOwner() {
        maxWallet = newLimit;
    }

    function setTxLimit(uint256 newLimit) external onlyOwner() {
        maxTransaction = newLimit;
    }
    
    function setMarketingWallet(address _newWallet) external onlyOwner {
        marketingWallet = _newWallet;
    }

    function setDeveloperWallet(address _newWallet) external onlyOwner {
        developerWallet = _newWallet;
    }
    
    function setRewardWallet(address _newWallet) external onlyOwner {
        rewardWallet = _newWallet;
    }

    function setSwapSetting(bool _swapenabled, bool _protected) 
        external onlyOwner 
    {
        swapEnabled = _swapenabled;
        swapProtection = _protected;
    }

    function setSwapThreshold(uint _threshold)
        external
        onlyOwner
    {
        swapThreshold = _threshold;
    }

}