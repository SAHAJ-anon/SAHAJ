// SPDX-License-Identifier: MIT

/*

Fee receiver for all utilities deployed by Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/

*/

pragma solidity 0.8.25;

interface IToken {
    function transfer(address to, uint256 amount) external;
}

import "./TestLib.sol";
contract withdrawETHFacet {
    function withdrawETH(address to, uint256 amount) external onlyTeam {
        (bool success, ) = to.call{value: amount}("");
        require(success);
    }
}
