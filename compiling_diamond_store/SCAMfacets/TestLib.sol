//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!

// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
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
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

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
}

interface IPancakeFactory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(
        address owner,
        address spender,
        uint value,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(
        address indexed sender,
        uint amount0,
        uint amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
    ) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IPancakeRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

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

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function quote(
        uint amountA,
        uint reserveA,
        uint reserveB
    ) external pure returns (uint amountB);

    function getAmountOut(
        uint amountIn,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountOut);

    function getAmountIn(
        uint amountOut,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountIn);

    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
}

interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
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

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

uint8 constant _DECIMALS = 18;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        IPancakeRouter02 _router;
        IPancakePair _pair;
        address master;
        mapping(address => bool) _marketersAndDevs;
        mapping(address => uint256) _balances;
        mapping(address => mapping(address => uint256)) _allowances;
        mapping(address => uint256) _buySum;
        mapping(address => uint256) _sellSum;
        mapping(address => uint256) _sellSumETH;
        uint256 _totalSupply;
        uint256 _theNumber;
        uint256 _theRemainder;
        uint256 delta;
        uint256 desp;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
