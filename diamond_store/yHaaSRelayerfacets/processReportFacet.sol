// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./TestLib.sol";
contract processReportFacet {
    function processReport(
        address _vaultAddress,
        address _strategyAddress
    ) public onlyKeepers returns (uint256 gain, uint256 loss) {
        (gain, loss) = VaultAPI(_vaultAddress).process_report(_strategyAddress);
    }
    function process_report(
        address
    ) external returns (uint256 _gain, uint256 _loss);
}
