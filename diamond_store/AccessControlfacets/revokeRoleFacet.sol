// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./TestLib.sol";
contract revokeRoleFacet {
    event RevokeRole(bytes32 role, address account);
    function revokeRole(
        bytes32 role,
        address _account
    ) external onlyRole(ds.DEFAULT_ADMIN_ROLE) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.roles[role][_account] = false;
        emit RevokeRole(role, _account);
    }
}
