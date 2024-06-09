/**

Moonifer Bot - THE GATEWAY FOR EVERY TRADER TO FIND THE NEXT MOONER ON ETHEREUM
                                         
https://moonifer.bot/
https://twitter.com/mooniferboteth
https://t.me/mooniferbot

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        mapping(address => uint256) balances;
        mapping(address => undefined) allowances;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
