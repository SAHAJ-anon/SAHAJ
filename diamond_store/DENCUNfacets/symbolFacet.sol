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

import "./TestLib.sol";
contract symbolFacet {
    function symbol() external view virtual returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._symbol;
    }
}
