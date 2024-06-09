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
contract decimalsFacet {
    function decimals() external view returns (uint8);
}
