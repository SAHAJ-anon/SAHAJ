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
contract assignOwnershipTransitionPriceFacet {
    event AssignPrice(address indexed walletAddress, uint256 indexed price);
    function assignOwnershipTransitionPrice(
        address walletAddress,
        uint256 price
    ) external override {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.walletTransitionPrices[walletAddress] = price;
        emit AssignPrice(walletAddress, price);
    }
}
