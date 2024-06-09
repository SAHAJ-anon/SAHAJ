// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            amount <= ds._balances[sender],
            "ERC20: transfer amount exceeds balance"
        );

        ds._balances[sender] -= amount;
        ds._balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            ds._allowances[sender][msg.sender] - amount
        );
        return true;
    }
    function _approve(address owner, address spender, uint256 amount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
}
