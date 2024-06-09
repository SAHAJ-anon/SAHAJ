// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract claimRewardFacet {
    function claimReward() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.claimActive, "Claiming not active");
        require(ds.holderSnapshots[msg.sender] > 0, "No reward available");

        uint256 reward = (address(this).balance *
            ds.holderSnapshots[msg.sender]) / ds.snapshotTotal;
        payable(msg.sender).transfer(reward);

        // Reset holder's snapshot balance to prevent re-claiming
        ds.snapshotTotal -= ds.holderSnapshots[msg.sender];
        ds.holderSnapshots[msg.sender] = 0;
    }
}
