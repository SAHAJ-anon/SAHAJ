//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;
import "./TestLib.sol";
contract getExpectedCompoundOutputByEthAmountFacet is DividendTracker, Ownable {
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableSet for EnumerableSet.AddressSet;

    function getExpectedCompoundOutputByEthAmount(
        uint256 rewardAmount
    ) external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address[] memory path = new address[](2);
        path[0] = ds.dexRouter.WETH();
        path[1] = address(ds.vitalikToken);
        uint256[] memory amounts = ds.dexRouter.getAmountsOut(
            rewardAmount,
            path
        );
        return amounts[1];
    }
}
