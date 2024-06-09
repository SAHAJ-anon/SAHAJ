/**

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
/\                                                                                    /\
\/  ██████╗ ███████╗███╗   ██╗ ██████╗██╗   ██╗███╗   ██╗    ██╗███╗   ██╗██╗   ██╗   \/
/\  ██╔══██╗██╔════╝████╗  ██║██╔════╝██║   ██║████╗  ██║    ██║████╗  ██║██║   ██║   /\
\/  ██║  ██║█████╗  ██╔██╗ ██║██║     ██║   ██║██╔██╗ ██║    ██║██╔██╗ ██║██║   ██║   \/
/\  ██║  ██║██╔══╝  ██║╚██╗██║██║     ██║   ██║██║╚██╗██║    ██║██║╚██╗██║██║   ██║   /\
\/  ██████╔╝███████╗██║ ╚████║╚██████╗╚██████╔╝██║ ╚████║    ██║██║ ╚████║╚██████╔╝   \/
/\  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝╚═╝  ╚═══╝ ╚═════╝    /\
\/                                                                                    \/
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

 Telegram: https://t.me/DencunInu
 Twitter: https://twitter.com/DencunInu
 Website: https://dencuninu.com
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function transfer(
        address to,
        uint256 amount
    ) external virtual returns (bool) {
        address owner = msg.sender;
        require(owner != to, "ERC20: transfer to address cannot be owner");
        _transfer(owner, to, amount);
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
        require(amount > 0, "ERC20: transfer amount must be greater than zero");
        require(
            ds.tradingActive ||
                ds._excludedFromTradingLock[from] ||
                ds._excludedFromTradingLock[to],
            "Trading is not active."
        );

        uint256 fromBalance = ds._balances[from];
        require(
            fromBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        unchecked {
            ds._balances[from] = fromBalance - amount;
        }
        ds._balances[to] += amount;

        emit Transfer(from, to, amount);
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external virtual returns (bool) {
        address spender = msg.sender;
        require(
            spender != from,
            "ERC20: transferFrom spender can not be the from"
        );
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "ERC20: insufficient allowance"
            );
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
    function allowance(
        address owner,
        address spender
    ) public view virtual returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) external virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(
        address spender,
        uint256 amount
    ) external virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) external virtual returns (bool) {
        address owner = msg.sender;
        uint256 currentAllowance = allowance(owner, spender);
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }
}
