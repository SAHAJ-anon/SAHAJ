// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface AutomationCompatibleInterface {
    function checkUpkeep(
        bytes calldata checkData
    ) external returns (bool upkeepNeeded, bytes memory performData);

    function performUpkeep(bytes calldata performData) external;
}

interface IRebalancer {
    function getToken0Address() external view returns (address);

    function getToken1Address() external view returns (address);

    function get24HourTotals() external view returns (uint256, uint256);

    function get7DayTotals() external view returns (uint256, uint256);

    function getPoolAddress() external view returns (address);

    function getEthDeposited() external view returns (uint256);

    function getToken0Collected() external view returns (uint256);

    function getToken1Collected() external view returns (uint256);

    function getTokenID() external view returns (uint256);

    function checkUpkeep(
        bytes calldata
    ) external view returns (bool, bytes memory);

    function performUpkeep(bytes calldata performData) external;

    function transferOwnership(address newOwner) external;
}

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

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        AggregatorV3Interface BTCPriceFeed;
        AggregatorV3Interface ETHPriceFeed;
        AggregatorV3Interface BNBPriceFeed;
        AggregatorV3Interface USDTPriceFeed;
        AggregatorV3Interface LINKPriceFeed;
        AggregatorV3Interface AVAXPriceFeed;
        AggregatorV3Interface SOLPriceFeed;
        AggregatorV3Interface MATICPriceFeed;
        address owner;
        undefined[] deployedRebalancers;
        uint256 batchSize;
        uint256 lastIndex;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
