// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint balance);
    function transfer(
        address recipient,
        uint amount
    ) external returns (bool success);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint remaining);
    function approve(
        address spender,
        uint amount
    ) external returns (bool success);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

//Actual Token Contract
import "./TestLib.sol";
contract approveFacet {
    event Approval(address indexed owner, address indexed spender, uint value);
    function approve(
        address spender,
        uint amount
    ) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}
