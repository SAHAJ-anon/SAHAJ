import "./TestLib.sol";
contract fromOctupleFacet {
    function fromOctuple(bytes32 x) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            bool negative = x &
                0x8000000000000000000000000000000000000000000000000000000000000000 >
                0;

            uint256 exponent = (uint256(x) >> 236) & 0x7FFFF;
            uint256 significand = uint256(x) &
                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

            if (exponent == 0x7FFFF) {
                if (significand > 0) return ds.NaN;
                else
                    return
                        negative ? ds.NEGATIVE_INFINITY : ds.POSITIVE_INFINITY;
            }

            if (exponent > 278526)
                return negative ? ds.NEGATIVE_INFINITY : ds.POSITIVE_INFINITY;
            else if (exponent < 245649)
                return negative ? ds.NEGATIVE_ZERO : ds.POSITIVE_ZERO;
            else if (exponent < 245761) {
                significand =
                    (significand |
                        0x100000000000000000000000000000000000000000000000000000000000) >>
                    (245885 - exponent);
                exponent = 0;
            } else {
                significand >>= 124;
                exponent -= 245760;
            }

            uint128 result = uint128(significand | (exponent << 112));
            if (negative) result |= 0x80000000000000000000000000000000;

            return bytes16(result);
        }
    }
}
