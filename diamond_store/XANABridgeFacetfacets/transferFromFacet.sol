/**
 *Submitted for verification at BscScan.com on 2024-03-13
 */

/**
 *Submitted for verification at Etherscan.io on 2024-03-08
 */

/**
 *Submitted for verification at testnet.bscscan.com on 2024-03-07
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IWXETA {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    function burn(address from, uint256 amount) external returns (bool);
    function mint(address receiver, uint256 amount) external returns (bool);
}

import "./TestLib.sol";
contract transferFromFacet {
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
