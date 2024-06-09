// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        // SHOULD NOT BE USED
        revert(
            "Sending Ether to Tetracoin_v1 ERC-20 Smart Contact isn't allowed."
        );
    }
}
