//SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "./TestLib.sol";
contract keccakFacet {
    function keccak(
        TestLib.slice memory self
    ) internal pure returns (bytes32 ret) {
        assembly {
            ret := keccak256(mload(add(self, 32)), mload(self))
        }
    }
}
