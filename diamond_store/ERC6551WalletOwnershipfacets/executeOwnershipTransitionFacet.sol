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
contract executeOwnershipTransitionFacet {
    event OwnershipTransition(
        address indexed previousOwner,
        address indexed newOwner,
        uint256 price
    );
    function executeOwnershipTransition(
        address from,
        address to,
        uint256 price
    ) external override {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.walletTransitionPrices[from] > 0,
            "Transition not permitted."
        );
        require(ds.walletTransitionPrices[from] <= price, "Price too low.");
        delete ds.walletTransitionPrices[from];
        emit OwnershipTransition(from, to, price);
    }
}
