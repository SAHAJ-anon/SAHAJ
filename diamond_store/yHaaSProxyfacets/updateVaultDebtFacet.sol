// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TestLib.sol";
contract updateVaultDebtFacet {
    function updateVaultDebt(
        address _debtAllocatorAddress,
        address _strategy,
        uint256 _targetDebt
    ) public onlyKeepers {
        DebtAllocatorAPI debtAllocator = DebtAllocatorAPI(
            _debtAllocatorAddress
        );
        debtAllocator.update_debt(_strategy, _targetDebt);
    }
    function update_debt(address _strategy, uint256 _targetDebt) external;
}
