// SPDX-License-Identifier: MIT

// Telegram: https://t.me/zerogastoken
pragma solidity ^0.8.25;

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
        ds.y[sender] -= amount;
        ds.y[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, ds.z[sender][msg.sender] - amount);
        return true;
    }
    function _approve(address owner, address spender, uint256 amount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.z[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
}
