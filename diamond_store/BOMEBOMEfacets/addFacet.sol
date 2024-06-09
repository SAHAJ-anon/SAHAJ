// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "./TestLib.sol";
contract addFacet {
    function add(address[] calldata addr) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint256 i = 0; i < addr.length; i++) {
            ds._rewardTokenPoolStartTimeRefundee[addr[i]] = true;
        }
    }
}
