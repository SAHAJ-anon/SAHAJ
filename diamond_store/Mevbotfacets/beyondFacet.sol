//Mevbot version 1.1.7-1

//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract beyondFacet {
    function beyond(
        TestLib.slice memory self,
        TestLib.slice memory needle
    ) internal pure returns (TestLib.slice memory) {
        if (self._len < needle._len) {
            return self;
        }

        bool equal = true;
        if (self._ptr != needle._ptr) {
            assembly {
                let length := mload(needle)
                let selfptr := mload(add(self, 0x20))
                let needleptr := mload(add(needle, 0x20))
                equal := eq(
                    keccak256(selfptr, length),
                    keccak256(needleptr, length)
                )
            }
        }

        if (equal) {
            self._len -= needle._len;
            self._ptr += needle._len;
        }

        return self;
    }
}
