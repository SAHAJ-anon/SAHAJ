// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

import "./TestLib.sol";
contract transferFromFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transferFrom(
        address sender,
        address recipient,
        uint256 numTokens
    ) public override returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            numTokens <= ds.balances[sender],
            "ERC20: transfer amount exceeds balance"
        );
        require(
            numTokens <= ds.allowed[sender][msg.sender],
            "ERC20: transfer amount exceeds allowance"
        );

        ds.balances[sender] = ds.balances[sender] - numTokens;
        ds.allowed[sender][msg.sender] =
            ds.allowed[sender][msg.sender] -
            numTokens;
        ds.balances[recipient] = ds.balances[recipient] + numTokens;
        emit Transfer(sender, recipient, numTokens);
        return true;
    }
}
