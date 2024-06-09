// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) external view returns (uint256);
    function withdrawToken(IERC20 token) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 contractBalance = token.balanceOf(address(this));
        require(token.transfer(ds.owner, contractBalance), "Transfer failed");
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}
