import "./TestLib.sol";
contract divisionWithoutRoundFacet {
    function divisionWithoutRound(
        uint256 x,
        uint256 y
    ) internal pure returns (uint256 z) {
        z = x / y;
    }
    function convertWadToAssetDecimalsWithoutRound(
        uint256 value,
        uint256 assetDecimals
    ) internal pure returns (uint256) {
        if (assetDecimals == 18) {
            return value;
        } else if (assetDecimals > 18) {
            return value * 10 ** (assetDecimals - 18);
        } else {
            return divisionWithoutRound(value, 10 ** (18 - assetDecimals));
        }
    }
}
