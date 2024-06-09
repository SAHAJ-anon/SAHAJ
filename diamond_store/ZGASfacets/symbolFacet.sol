// SPDX-License-Identifier: MIT

// Telegram: https://t.me/zerogastoken
pragma solidity ^0.8.25;

import "./TestLib.sol";
contract symbolFacet {
    function symbol() external pure returns (string memory) {
        return "ZGAS";
    }
}
