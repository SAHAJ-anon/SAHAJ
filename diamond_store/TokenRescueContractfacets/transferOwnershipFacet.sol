// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract transferOwnershipFacet {
    function transferOwnership(address newOwner) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(newOwner != address(0), "New ds.owner is the zero address.");
        ds.owner = newOwner;
    }
}
