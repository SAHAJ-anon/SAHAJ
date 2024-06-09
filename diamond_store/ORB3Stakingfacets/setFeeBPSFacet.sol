/**
 *Submitted for verification at Etherscan.io on 2024-03-11
 */

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

import "./TestLib.sol";
contract setFeeBPSFacet {
    function setFeeBPS(uint256 _feeBPS) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_feeBPS <= 10000, "fee failed"); // Ensuring the fee doesn't exceed 100%
        ds.feeBPS = _feeBPS;
    }
}
