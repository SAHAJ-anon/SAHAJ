// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./TestLib.sol";
contract tendStrategyFacet {
    function tendStrategy(address _strategyAddress) public onlyKeepers {
        StrategyAPI(_strategyAddress).tend();
    }
    function tend() external;
}
