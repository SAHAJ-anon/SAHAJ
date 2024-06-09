// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
// Telegram: https://t.me/AssemblyERC20Portal
// Twitter: https://twitter.com/AssemblyERC20

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public pure returns (uint8) {
        assembly {
            mstore(0x0, 18)
            return(0x0, 0x20)
        }
    }
}
