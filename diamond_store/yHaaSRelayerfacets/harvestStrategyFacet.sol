// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./TestLib.sol";
contract harvestStrategyFacet {
    function harvestStrategy(
        address _strategyAddress
    ) public onlyKeepers returns (uint256 profit, uint256 loss) {
        (profit, loss) = StrategyAPI(_strategyAddress).report();
    }
    function report() external returns (uint256 _profit, uint256 _loss);
}
