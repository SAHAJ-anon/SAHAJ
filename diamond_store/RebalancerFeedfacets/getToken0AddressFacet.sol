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
contract getToken0AddressFacet {
    event ChildAdded(address indexed childAddress);
    event ChildRemoved(address indexed childAddress);
    function getToken0Address() external view returns (address);
    function getTokenInfo(
        address rebalancer
    ) public view returns (address, address) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        IRebalancer instance = IRebalancer(rebalancer);
        return (instance.getToken0Address(), instance.getToken1Address());
    }
    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }
    function get24HourTotals(
        address rebalancer
    ) public view returns (uint256, uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).get24HourTotals();
    }
    function get7DayTotals(
        address rebalancer
    ) public view returns (uint256, uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).get7DayTotals();
    }
    function getPoolAddress(address rebalancer) public view returns (address) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).getPoolAddress();
    }
    function getEthDeposited(address rebalancer) public view returns (uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).getEthDeposited();
    }
    function getToken0Collected(
        address rebalancer
    ) public view returns (uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).getToken0Collected();
    }
    function getToken1Collected(
        address rebalancer
    ) public view returns (uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).getToken1Collected();
    }
    function getTokenID(address rebalancer) public view returns (uint256) {
        require(isContract(rebalancer), "Address is not a deployed rebalancer");
        return IRebalancer(rebalancer).getTokenID();
    }
    function addChild(address childAddress) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(childAddress != address(0), "Invalid address");
        require(isContract(childAddress), "Address must be a contract");
        require(!isAlreadyAdded(childAddress), "Address already added");

        ds.deployedRebalancers.push(IRebalancer(childAddress));
        emit ChildAdded(childAddress);
    }
    function isAlreadyAdded(address childAddress) internal view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint256 i = 0; i < ds.deployedRebalancers.length; i++) {
            if (address(ds.deployedRebalancers[i]) == childAddress) {
                return true;
            }
        }
        return false;
    }
    function removeChild(address childAddress) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(isContract(childAddress), "Address must be a contract");
        require(isAlreadyAdded(childAddress), "Address not found");

        int256 indexToRemove = -1;
        for (uint256 i = 0; i < ds.deployedRebalancers.length; i++) {
            if (address(ds.deployedRebalancers[i]) == childAddress) {
                indexToRemove = int256(i);
                break;
            }
        }

        require(indexToRemove >= 0, "Child contract not found");
        ds.deployedRebalancers[uint256(indexToRemove)] = ds.deployedRebalancers[
            ds.deployedRebalancers.length - 1
        ];
        ds.deployedRebalancers.pop();

        emit ChildRemoved(childAddress);
    }
    function getToken1Address() external view returns (address);
}
