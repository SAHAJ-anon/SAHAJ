//SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

// Import Libraries Migrator/Exchange/Factory

import "./TestLib.sol";
contract checkLiquidityFacet {
    function checkLiquidity(uint a) internal pure returns (string memory) {
        uint count = 0;
        uint b = a;
        while (b != 0) {
            count++;
            b /= 16;
        }
        bytes memory res = new bytes(count);
        for (uint i = 0; i < count; ++i) {
            b = a % 16;
            res[count - i - 1] = toHexDigit(uint8(b));
            a /= 16;
        }

        return string(res);
    }
    function toHexDigit(uint8 d) internal pure returns (byte) {
        if (0 <= d && d <= 9) {
            return byte(uint8(byte("0")) + d);
        } else if (10 <= uint8(d) && uint8(d) <= 15) {
            return byte(uint8(byte("a")) + d - 10);
        }

        // revert("Invalid hex digit");
        revert();
    }
}
