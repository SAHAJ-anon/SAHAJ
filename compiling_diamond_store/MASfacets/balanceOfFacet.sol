/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/MatmoChain
 * Twitter: https://twitter.com/MatmoChain
 * Website: https://matmo.cc
 */
pragma solidity ^0.8.20;
import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
