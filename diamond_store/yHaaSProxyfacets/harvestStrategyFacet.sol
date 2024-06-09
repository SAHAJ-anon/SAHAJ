// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract harvestStrategyFacet {
    function harvestStrategy(address _strategyAddress) public onlyKeepers {
        StrategyAPI strategy = StrategyAPI(_strategyAddress);
        strategy.report();
    }
    function report() external returns (uint256 _profit, uint256 _loss);
}
