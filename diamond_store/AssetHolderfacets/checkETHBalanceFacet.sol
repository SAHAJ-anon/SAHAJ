// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.24;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract checkETHBalanceFacet {
    function checkETHBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
