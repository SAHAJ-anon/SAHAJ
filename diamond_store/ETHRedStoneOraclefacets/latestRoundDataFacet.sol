// SPDX-License-Identifier: AGPL-v3.0
pragma solidity ^0.8.21;

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(
        uint80 _roundId
    )
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

/// @title ETHRedStoneOracle
/// @author Jason (Sturdy) https://github.com/iris112
/// @notice  An oracle for ETH/asset (has RedStone price)
import "./TestLib.sol";
contract latestRoundDataFacet {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
    function getPrices()
        external
        view
        returns (bool _isBadData, uint256 _priceLow, uint256 _priceHigh)
    {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int256 _answer, , uint256 _updatedAt, ) = AggregatorV3Interface(
            ds.REDSTONE_ASSET_ETH_PRICE
        ).latestRoundData();
        // If data is stale or negative, set bad data to true and return
        if (
            _answer <= 0 || (block.timestamp - _updatedAt > ds.MAX_ORACLE_DELAY)
        ) {
            revert REDSTONE_BAD_PRICE();
        }
        uint256 rate = 1e26 / uint256(_answer); // ETH/ASSET, redstone price decimal is 8

        _priceHigh = rate > ds.PRICE_MIN ? rate : ds.PRICE_MIN;
        _priceLow = _priceHigh;
    }
}
