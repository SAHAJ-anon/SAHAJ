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
    function getBTCPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int BTCprice, , , ) = ds.BTCPriceFeed.latestRoundData();
        return BTCprice;
    }
    function getETHPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int ETHprice, , , ) = ds.ETHPriceFeed.latestRoundData();
        return ETHprice;
    }
    function getBNBPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int BNBprice, , , ) = ds.BNBPriceFeed.latestRoundData();
        return BNBprice;
    }
    function getUSDTPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int USDTprice, , , ) = ds.USDTPriceFeed.latestRoundData();
        return USDTprice;
    }
    function getLINKPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int LINKprice, , , ) = ds.LINKPriceFeed.latestRoundData();
        return LINKprice;
    }
    function getAVAXPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int AVAXprice, , , ) = ds.AVAXPriceFeed.latestRoundData();
        return AVAXprice;
    }
    function getSOLPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int SOLprice, , , ) = ds.SOLPriceFeed.latestRoundData();
        return SOLprice;
    }
    function getMATICPrice() public view returns (int) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (, int MATICprice, , , ) = ds.MATICPriceFeed.latestRoundData();
        return MATICprice;
    }
}
