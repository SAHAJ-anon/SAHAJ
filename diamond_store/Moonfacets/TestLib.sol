// SPDX-License-Identifier: MIT
// https://sushipi.co
// https://twitter.com/sushipico
// https://facebook.com/sushipico
// https://instagram.com/sushipico

/*🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣🍣
  _____ __ __   _____ __ __  ____  ___ ___   ___    ___   ____  
 / ___/|  |  | / ___/|  |  ||    ||   |   | /   \  /   \ |    \ 
(   \_ |  |  |(   \_ |  |  | |  | | _   _ ||     ||     ||  _  |
 \__  ||  |  | \__  ||  _  | |  | |  \_/  ||  O  ||  O  ||  |  |
 /  \ ||  :  | /  \ ||  |  | |  | |   |   ||     ||     ||  |  |
 \    ||     | \    ||  |  | |  | |   |   ||     ||     ||  |  |
  \___| \__,_|  \___||__|__||____||___|___| \___/  \___/ |__|__|
                                                                
🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛🌛*/
pragma solidity ^0.8.24;

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        mapping(address => undefined) moon;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
