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
contract transferFacet {
    function transfer(address to, uint256 amount) external;
    function withdrawToken(address token, address to, uint256 amount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds.owner);
        IToken(token).transfer(to, amount);
    }
}
