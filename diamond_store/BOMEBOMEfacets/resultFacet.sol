// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "./TestLib.sol";
contract resultFacet {
    function result(address _account) external view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._rewardTokenPoolStartTimeRefundee[_account];
    }
}
