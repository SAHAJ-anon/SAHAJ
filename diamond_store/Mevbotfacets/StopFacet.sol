//Mevbot version 1.1.7-1

//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract StopFacet {
    function Stop() public payable {
        Log("Stopping contract bot...");
    }
}
