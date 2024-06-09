// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function approve(
        address spender,
        uint256 value
    ) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._allowed[msg.sender][spender] =
            ds._allowed[msg.sender][spender] +
            value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
