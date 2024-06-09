/** 
 (               (                            (     
 )\ )            )\ )           )      (      )\ )  
(()/(         ) (()/(     )  ( /(      )\    (()/(  
 /(_)) (   ( /(  /(_)) ( /(  )\())  ((((_)(   /(_)) 
(_))_| )\  )\())(_))   )(_))((_)\    )\ _ )\ (_))   
| |_  ((_)((_)\ | |   ((_)_ | |(_)   (_)_\(_)|_ _|  
| __|/ _ \\ \ / | |__ / _` || '_ \ _  / _ \   | |   
|_|  \___//_\_\ |____|\__,_||_.__/(_)/_/ \_\ |___|  

Web: https://foxlabai.solutions

TG: https://t.me/FoxLabAi_Portal

Twitter (X): https://twitter.com/FoxLabAi

Launch 18TH 18:00 UTC

**/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        uint8 _decimals;
        uint256 _tTotal;
        string _name;
        string _symbol;
        mapping(address => uint256) balances;
        mapping(address => undefined) allowed;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
