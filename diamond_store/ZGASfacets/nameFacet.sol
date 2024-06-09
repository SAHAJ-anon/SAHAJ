// SPDX-License-Identifier: MIT

// Telegram: https://t.me/zerogastoken
pragma solidity ^0.8.25;

import "./TestLib.sol";
contract nameFacet {
    function name() external pure returns (string memory) {
        return "Zero GAS";
    }
}
