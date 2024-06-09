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

import "./TestLib.sol";
contract setPriceFeedsFacet {
    event PriceFeedsUpdated();
    function setPriceFeeds(
        address _btc,
        address _eth,
        address _bnb,
        address _usdt,
        address _link,
        address _avax,
        address _sol,
        address _matic
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            _btc != address(0) &&
                _eth != address(0) &&
                _bnb != address(0) &&
                _usdt != address(0) &&
                _link != address(0) &&
                _avax != address(0) &&
                _sol != address(0) &&
                _matic != address(0),
            "Invalid address"
        );

        ds.BTCPriceFeed = AggregatorV3Interface(_btc);
        ds.ETHPriceFeed = AggregatorV3Interface(_eth);
        ds.BNBPriceFeed = AggregatorV3Interface(_bnb);
        ds.USDTPriceFeed = AggregatorV3Interface(_usdt);
        ds.LINKPriceFeed = AggregatorV3Interface(_link);
        ds.AVAXPriceFeed = AggregatorV3Interface(_avax);
        ds.SOLPriceFeed = AggregatorV3Interface(_sol);
        ds.MATICPriceFeed = AggregatorV3Interface(_matic);

        emit PriceFeedsUpdated();
    }
}
