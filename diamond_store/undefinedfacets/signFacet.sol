import "./TestLib.sol";
contract signFacet {
    function sign(bytes16 x) internal pure returns (int8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint128 absoluteX = uint128(x) & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

            require(absoluteX <= 0x7FFF0000000000000000000000000000); // Not ds.NaN

            if (absoluteX == 0) return 0;
            else if (uint128(x) >= 0x80000000000000000000000000000000)
                return -1;
            else return 1;
        }
    }
}
