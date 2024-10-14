// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;
import "./TestLib.sol";
contract transferOwnershipFacet {
    using SafeERC20 for IERC20;

    modifier inProgress() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            !ds.isPaused,
            "TrestleStakingPool::initialized: staking is paused"
        );
        require(
            ds.startsAt <= block.timestamp,
            "TrestleStakingPool::initialized: staking has not started yet"
        );
        require(
            ds.endsAt > block.timestamp,
            "TrestleStakingPool::notFinished: staking has finished"
        );
        _;
    }
    modifier onlyOwner() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            msg.sender == ds.owner,
            "TrestleStakingPool::onlyOwner: not authorized"
        );
        _;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    function transferOwnership(address _newOwner) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address currentOwner = ds.owner;
        ds.owner = _newOwner;
        emit OwnershipTransferred(currentOwner, _newOwner);
    }
}
