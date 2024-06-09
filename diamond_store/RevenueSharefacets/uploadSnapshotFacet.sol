// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract uploadSnapshotFacet {
    function uploadSnapshot(
        address[] calldata addresses,
        uint256[] calldata balances
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(addresses.length == balances.length, "Array length mismatch");
        uint256 total = 0;
        for (uint i = 0; i < addresses.length; i++) {
            if (balances[i] >= 1000 * 10 ** 18) {
                // Assuming OPMND has 18 decimals
                ds.holderSnapshots[addresses[i]] = balances[i];
                total += balances[i];
            }
        }
        ds.snapshotTotal = total;
    }
}
