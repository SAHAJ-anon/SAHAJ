// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./TestLib.sol";
contract aggregateFacet {
    function aggregate(
        TestLib.Call[] calldata calls
    ) public payable returns (uint256 blockNumber, bytes[] memory returnData) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds.owner);

        blockNumber = block.number;
        uint256 length = calls.length;
        returnData = new bytes[](length);
        TestLib.Call calldata call;
        for (uint256 i = 0; i < length; ) {
            bool success;
            call = calls[i];
            (success, returnData[i]) = call.target.call(call.callData);
            require(success, "Multicall3: call failed");
            unchecked {
                ++i;
            }
        }
    }
}
