// SPDX-License-Identifier: MIT

/*

Utility contract to purchase premium memberships for Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/premium

*/

pragma solidity 0.8.25;

interface IUtilPremium {
    function addPremium(address account) external;
    function addPremiumPlus(address account) external;
}

interface IToken {
    function transfer(address to, uint256 amount) external;
}

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        getPremiumETH(msg.sender);
    }
}
