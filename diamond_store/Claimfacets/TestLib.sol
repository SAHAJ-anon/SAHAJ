// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct Allocation {
        uint256 airdrop;
        uint256 presale;
        uint256 claimedAirdrop;
        uint256 claimedPresale;
        bool hasClaimedInitial;
    }
    struct TestStorage {
        address owner;
        address treasuryContract;
        IERC20 token;
        uint256 startTime;
        uint256 INITIAL_RELEASE_PERCENTAGE;
        uint256 MONTHLY_RELEASE_PERCENTAGE;
        uint256 ONE_MONTH;
        uint256 AirdropForfeit;
        mapping(address => undefined) allocations;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
