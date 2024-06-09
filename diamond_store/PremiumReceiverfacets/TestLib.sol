// SPDX-License-Identifier: MIT

/*

Utility contract to purchase premium memberships for Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/premium

*/

pragma solidity 0.8.25;

interface IUtilPremium {
    function addPremium(address account) external;
    function addPremiumPlus(address account) external;
}

interface IToken {
    function transfer(address to, uint256 amount) external;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address utilPremium;
        address utilRecovery;
        mapping(address => bool) team;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
