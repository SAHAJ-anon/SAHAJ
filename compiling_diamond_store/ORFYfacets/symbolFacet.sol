/*
 * SPDX-License-Identifier: MIT
 * Website:  https://ordify.world/
 * Telegram: https://t.me/ordify
 * Twitter:  https://twitter.com/ordifyworld
 */
pragma solidity ^0.8.22;
import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
