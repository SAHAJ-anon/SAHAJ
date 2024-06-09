// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
// Telegram: https://t.me/AssemblyERC20Portal
// Twitter: https://twitter.com/AssemblyERC20

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
