/**

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
/\                                                                                    /\
\/  ██████╗ ███████╗███╗   ██╗ ██████╗██╗   ██╗███╗   ██╗    ██╗███╗   ██╗██╗   ██╗   \/
/\  ██╔══██╗██╔════╝████╗  ██║██╔════╝██║   ██║████╗  ██║    ██║████╗  ██║██║   ██║   /\
\/  ██║  ██║█████╗  ██╔██╗ ██║██║     ██║   ██║██╔██╗ ██║    ██║██╔██╗ ██║██║   ██║   \/
/\  ██║  ██║██╔══╝  ██║╚██╗██║██║     ██║   ██║██║╚██╗██║    ██║██║╚██╗██║██║   ██║   /\
\/  ██████╔╝███████╗██║ ╚████║╚██████╗╚██████╔╝██║ ╚████║    ██║██║ ╚████║╚██████╔╝   \/
/\  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝╚═╝  ╚═══╝ ╚═════╝    /\
\/                                                                                    \/
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

 Telegram: https://t.me/DencunInu
 Twitter: https://twitter.com/DencunInu
 Website: https://dencuninu.com
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => uint256) _balances;
        mapping(address => undefined) _allowances;
        string _name;
        string _symbol;
        uint8 _decimals;
        uint256 _totalSupply;
        bool tradingActive;
        mapping(address => bool) _excludedFromTradingLock;
        address _owner;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
