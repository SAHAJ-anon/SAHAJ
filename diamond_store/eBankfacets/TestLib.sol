// SPDX-License-Identifier: MIT
/**                  __                 v1.1+
                    / _|                     
   __ _  __ _ _   _| |_                      
  / _` |/ _` | | | |  _|__              _    
 | (_| | (_| | |_| | |  _ \            | |   
  \__, |\__, |\__,_|_| |_) | __ _ _ __ | | __
   __/ | __/ |   / _ \  _ < / _` | '_ \| |/ /
  |___/ |___/   |  __/ |_) | (_| | | | |   < 
                 \___|____/ \__,_|_| |_|_|\_\
*/
pragma solidity ^0.8.25;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => uint) balances;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
