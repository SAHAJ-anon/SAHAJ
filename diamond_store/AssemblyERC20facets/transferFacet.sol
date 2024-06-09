// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
// Telegram: https://t.me/AssemblyERC20Portal
// Twitter: https://twitter.com/AssemblyERC20

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
        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
}
