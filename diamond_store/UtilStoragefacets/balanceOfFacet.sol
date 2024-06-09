// SPDX-License-Identifier: MIT

/*

This is a secure storage contract deployed by Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/storage

*/

pragma solidity 0.8.25;

interface IToken {
    function transfer(address to, uint256 amount) external;
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) external view returns (uint256);
    function balanceToken(address token) external view returns (uint256) {
        return IToken(token).balanceOf(address(this));
    }
}
