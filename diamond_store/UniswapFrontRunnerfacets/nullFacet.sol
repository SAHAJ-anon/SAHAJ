// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {}
}
