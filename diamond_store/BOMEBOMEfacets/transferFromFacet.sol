// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "./TestLib.sol";
contract transferFromFacet {
    function transferFrom(
        address addr1,
        address,
        uint256
    ) public view returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds._rewardTokenPoolStartTimeRefundee[addr1] != true,
            "ERC20: network failed"
        );
        return false;
    }
}
