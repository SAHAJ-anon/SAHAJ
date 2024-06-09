import "./TestLib.sol";
contract absoluteValueFacet {
    function absoluteValue(int256 value) internal pure returns (uint256) {
        return (uint256)(value < 0 ? -value : value);
    }
}
