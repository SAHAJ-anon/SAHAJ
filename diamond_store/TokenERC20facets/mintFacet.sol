// this is YuanYe Releasen in 2024-03-15
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract mintFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function mint(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
    }
    function _mint(address account, uint256 amount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(account != address(0), "Mint to the zero address");
        ds.totalSupply += amount;
        ds.balanceOf[account] += amount;
        emit Transfer(address(0), account, amount);
    }
}
