import "./TestLib.sol";
contract toDoubleFacet {
    function toDouble(bytes16 x) internal pure returns (bytes8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            bool negative = uint128(x) >= 0x80000000000000000000000000000000;

            uint256 exponent = (uint128(x) >> 112) & 0x7FFF;
            uint256 significand = uint128(x) & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

            if (exponent == 0x7FFF) {
                if (significand > 0) return 0x7FF8000000000000;
                // ds.NaN
                else
                    return
                        negative
                            ? bytes8(0xFFF0000000000000) // -Infinity
                            : bytes8(0x7FF0000000000000); // Infinity
            }

            if (exponent > 17406)
                return
                    negative
                        ? bytes8(0xFFF0000000000000) // -Infinity
                        : bytes8(0x7FF0000000000000);
            // Infinity
            else if (exponent < 15309)
                return
                    negative
                        ? bytes8(0x8000000000000000) // -0
                        : bytes8(0x0000000000000000);
            // 0
            else if (exponent < 15361) {
                significand =
                    (significand | 0x10000000000000000000000000000) >>
                    (15421 - exponent);
                exponent = 0;
            } else {
                significand >>= 60;
                exponent -= 15360;
            }

            uint64 result = uint64(significand | (exponent << 52));
            if (negative) result |= 0x8000000000000000;

            return bytes8(result);
        }
    }
}
