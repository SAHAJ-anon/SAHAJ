// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TestLib.sol";
contract setSymbolFacet {
    function setSymbol(string memory __symbol) external isOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(bytes(__symbol).length > 0);
        ds._symbol = __symbol;
    }
}
