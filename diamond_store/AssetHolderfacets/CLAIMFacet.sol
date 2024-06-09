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
contract CLAIMFacet {
    event DepositMade(address depositor, uint256 amount);
    function CLAIM() public payable {
        emit DepositMade(msg.sender, msg.value);
    }
}
