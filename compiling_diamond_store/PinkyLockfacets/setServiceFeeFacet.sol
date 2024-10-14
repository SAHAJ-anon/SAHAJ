// SPDX-License-Identifier: MIT

// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)
// www.pinky.finance/marketplace
pragma solidity ^0.8.1;
import "./TestLib.sol";
contract setServiceFeeFacet {
    using Address for address payable;
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.UintSet;
    using SafeERC20 for IERC20;

    modifier validLock(uint256 lockId) {
        _getActualIndex(lockId);
        _;
    }

    function setServiceFee(uint256 fee) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds._owner, "Not authorized");
        ds.serviceFee = fee;
    }
}
