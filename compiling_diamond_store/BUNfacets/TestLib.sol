/*
THE BIGGEST BUBBLE RUN - Ride the Bubble, But Don't Get Popped!

Welcome to The Biggest Bubble Run (BUN), the most exhilarating and entertaining ride through the wild world of market bubbles! Hold onto your seats as we embark on a journey to explore the biggest bubble in human history, filled with thrills, spills, and a whole lot of fun. But remember, while we're here to have a blast, we'll also keep a watchful eye on the risks that bubbles bring. Get ready for a crypto adventure like no other!

At BUN, we're all about turning the concept of market bubbles into a rollicking good time! We're not your typical crypto token; we're here for the sheer joy of it. Our mission? To bring laughter, memes, and a sense of camaraderie to the crypto community, all while playfully reminding you that bubbles can be both a chance and a risk. So hop on board, enjoy the ride, and let's make some unforgettable memories together. Bubbles, beware—BUN is here to show you how to have a blast while staying informed.

WEB | https://thebiggestbubblerun.co
TG  | https://t.me/BUN_Portal
X   | https://twitter.com/BUN_token
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
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

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
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

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
}

contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
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
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
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
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);
}

uint8 constant _decimals = 9;
uint256 constant _tTotal = 1000000000 * 10 ** _decimals;
string constant _name = unicode"The Biggest Bubble Run";
string constant _symbol = unicode"BUN";

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => uint256) _balances;
        mapping(address => mapping(address => uint256)) _allowances;
        mapping(address => bool) _isExcludedFromFee;
        mapping(address => bool) bots;
        mapping(address => uint256) _holderLastTransferTimestamp;
        bool transferDelayEnabled;
        address payable _taxWallet;
        uint256 _initialBuyTax;
        uint256 _initialSellTax;
        uint256 _finalBuyTax;
        uint256 _finalSellTax;
        uint256 _reduceBuyTaxAt;
        uint256 _reduceSellTaxAt;
        uint256 _preventSwapBefore;
        uint256 _buyCount;
        uint256 _maxTxAmount;
        uint256 _maxWalletSize;
        uint256 _taxSwapThreshold;
        uint256 _maxTaxSwap;
        IUniswapV2Router02 uniswapV2Router;
        address uniswapV2Pair;
        bool tradingOpen;
        bool inSwap;
        bool swapEnabled;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
