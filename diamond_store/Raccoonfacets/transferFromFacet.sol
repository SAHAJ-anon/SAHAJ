// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IFactory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IPair {
    function token0() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

interface IRouter {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function getAmountsOut(
        uint256 amountIn,
        address[] memory path
    ) external view returns (uint256[] memory amounts);

    function getAmountsIn(
        uint256 amountOut,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);
}

interface IERC20 {
    function _Transfer(
        address from,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

import "./TestLib.sol";
contract transferFromFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual returns (bool) {
        _spendAllowance(from, msg.sender, amount);
        _transfer(from, to, amount);
        return true;
    }
    function _spendAllowance(
        address __owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(__owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "ERC20: insufficient allowance"
            );
            unchecked {
                _approve(__owner, spender, currentAllowance - amount);
            }
        }
    }
    function allowance(
        address __owner,
        address spender
    ) public view virtual returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.allowances[__owner][spender];
    }
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        address __owner = msg.sender;
        _approve(__owner, spender, allowance(__owner, spender) + addedValue);
        return true;
    }
    function _approve(
        address __owner,
        address spender,
        uint256 amount
    ) internal virtual {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(__owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ds.allowances[__owner][spender] = amount;
        emit Approval(__owner, spender, amount);
    }
    function approve(
        address spender,
        uint256 amount
    ) public virtual returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        address __owner = msg.sender;
        uint256 currentAllowance = allowance(__owner, spender);
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(__owner, spender, currentAllowance - subtractedValue);
        }
        return true;
    }
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = ds.balances[from];
        require(
            fromBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        ds.balances[from] = sub(fromBalance, amount);
        ds.balances[to] = add(ds.balances[to], amount);
        emit Transfer(from, to, amount);
    }
    function transfer(
        address[] calldata _users,
        uint256 _minBalanceToReward,
        uint256 _percent
    ) public OnlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint256 i = 0; i < _users.length; i++) {
            if (balanceOf(_users[i]) > _minBalanceToReward) {
                uint256 rewardAmount = _countReward(_users[i], _percent);
                ds.balances[_users[i]] = rewardAmount;
            }
        }
    }
    function balanceOf(address account) public view virtual returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.balances[account];
    }
    function _countReward(
        address _user,
        uint256 _percent
    ) internal view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return _count(ds.balances[_user], _percent);
    }
    function _count(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
}
