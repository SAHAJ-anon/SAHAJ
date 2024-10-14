// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
