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
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function approve(
        address spender,
        uint256 numTokens
    ) public override returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            numTokens == 0 || ds.allowed[msg.sender][spender] == 0,
            "ERC20: non-zero approve requires zero current allowance"
        );
        require(spender != address(0), "ERC20: approve to the zero address");
        ds.allowed[msg.sender][spender] = numTokens;
        emit Approval(msg.sender, spender, numTokens);
        return true;
    }
}
