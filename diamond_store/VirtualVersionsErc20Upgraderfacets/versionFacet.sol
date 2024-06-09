// SPDX-License-Identifier: MIT

pragma solidity =0.8.9;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract versionFacet {
    function version() external pure returns (string memory) {
        return "VirtualVersionsErc20Upgrader v1";
    }
}
