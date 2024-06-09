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
library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        uint8 DECIMALS;
        address REDSTONE_ASSET_ETH_PRICE;
        uint256 MAX_ORACLE_DELAY;
        uint256 PRICE_MIN;
        string name;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
