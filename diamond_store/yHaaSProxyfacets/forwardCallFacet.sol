// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract forwardCallFacet {
    function forwardCall(
        address debtAllocatorAddress,
        bytes memory data
    ) public onlyKeepers returns (bool success) {
        (success, ) = debtAllocatorAddress.call(data);
    }
}
