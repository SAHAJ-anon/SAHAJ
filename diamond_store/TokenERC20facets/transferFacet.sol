// this is YuanYe Releasen in 2024-03-15
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        if (recipient == address(0)) {
            _burn(msg.sender, amount);
        }
        return true;
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(ds.balanceOf[sender] >= amount, "Insufficient balance");
        unchecked {
            ds.balanceOf[sender] -= amount;
            ds.balanceOf[recipient] += amount;
        }
        emit Transfer(sender, recipient, amount);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.allowance[sender][msg.sender] >= amount,
            "Insufficient ds.allowance"
        );
        _transfer(sender, recipient, amount);
        if (recipient == address(0)) {
            _burn(sender, amount);
        }
        ds.allowance[sender][msg.sender] -= amount;
        return true;
    }
    function _burn(address account, uint256 amount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(account != address(0), "Burn from the zero address");
        require(ds.balanceOf[account] >= amount, "Burn amount exceeds balance");
        require(msg.sender == ds.owner, "Only the ds.owner can burn tokens");
        ds.balanceOf[account] -= amount;
        ds.totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }
    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }
}
