// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract tendStrategyFacet {
    function tendStrategy(address _strategyAddress) public onlyKeepers {
        StrategyAPI strategy = StrategyAPI(_strategyAddress);
        strategy.tend();
    }
    function tend() external;
}
