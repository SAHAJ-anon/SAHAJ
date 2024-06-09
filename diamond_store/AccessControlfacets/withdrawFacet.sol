// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./TestLib.sol";
contract withdrawFacet {
    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
