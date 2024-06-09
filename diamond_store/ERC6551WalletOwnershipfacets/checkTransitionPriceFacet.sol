// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.4;

interface IERC6551 {
    function assignOwnershipTransitionPrice(
        address walletAddress,
        uint256 price
    ) external;
    function executeOwnershipTransition(
        address from,
        address to,
        uint256 price
    ) external;
}

import "./TestLib.sol";
contract checkTransitionPriceFacet {
    function checkTransitionPrice(
        address walletAddress
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.walletTransitionPrices[walletAddress];
    }
}
