// SPDX-License-Identifier: MIT

/*

This contract is a safe utility token deployed by Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/standard

*/

pragma solidity 0.8.25;
import "./TestLib.sol";
contract updateFeeReceiverFacet {
    modifier onlyOwner() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds.owner);
        _;
    }

    function updateFeeReceiver(address newFeeReceiver) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(newFeeReceiver != address(0));
        ds.feeReceiver = newFeeReceiver;
    }
}
