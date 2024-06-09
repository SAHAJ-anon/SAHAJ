import "./TestLib.sol";
contract to64x64Facet {
    function to64x64(bytes16 x) internal pure returns (int128) {
        unchecked {
            uint256 exponent = (uint128(x) >> 112) & 0x7FFF;

            require(exponent <= 16446); // Overflow
            if (exponent < 16319) return 0; // Underflow

            uint256 result = (uint256(uint128(x)) &
                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                0x10000000000000000000000000000;

            if (exponent < 16431) result >>= 16431 - exponent;
            else if (exponent > 16431) result <<= exponent - 16431;

            if (uint128(x) >= 0x80000000000000000000000000000000) {
                // Negative
                require(result <= 0x80000000000000000000000000000000);
                return -int128(int256(result)); // We rely on overflow behavior here
            } else {
                require(result <= 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
                return int128(int256(result));
            }
        }
    }
}
