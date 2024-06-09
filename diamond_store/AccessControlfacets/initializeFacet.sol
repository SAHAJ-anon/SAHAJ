// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./TestLib.sol";
contract initializeFacet {
    event GrantRole(bytes32 role, address account);
    function initialize() public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        //Anyone can call the init function
        _grantRole(ds.DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ds.REVIEWER_ROLE, msg.sender);
    }
    function _grantRole(bytes32 _role, address _account) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.roles[_role][_account] = true;
    }
    function grantRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ds.DEFAULT_ADMIN_ROLE) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _grantRole(_role, _account);
        emit GrantRole(_role, _account);
    }
}
