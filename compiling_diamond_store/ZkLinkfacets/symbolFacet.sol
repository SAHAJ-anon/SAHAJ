/*
 * SPDX-License-Identifier: MIT
 * Website: https://zk.link/
 */
pragma solidity ^0.8.23;
import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
