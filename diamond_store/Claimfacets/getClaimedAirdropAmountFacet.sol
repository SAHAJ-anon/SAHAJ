// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract getClaimedAirdropAmountFacet {
    function getClaimedAirdropAmount(
        address userAddress
    ) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.allocations[userAddress].claimedAirdrop;
    }
}
