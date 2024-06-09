//SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "./TestLib.sol";
contract memcpyFacet {
    function memcpy(uint dest, uint src, uint len) private pure {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        // Check available ds.liquidity
        for (; len >= 32; len -= 32) {
            assembly {
                mstore(dest, mload(src))
            }
            dest += 32;
            src += 32;
        }

        // Copy remaining bytes
        uint mask = 256 ** (32 - len) - 1;
        assembly {
            let srcpart := and(mload(src), not(mask))
            let destpart := and(mload(dest), mask)
            mstore(dest, or(destpart, srcpart))
        }
    }
}
