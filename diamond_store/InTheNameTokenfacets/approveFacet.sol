// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function approve(address spender, uint256 value) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
