// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import "./TestLib.sol";
contract nameFacet is Ownable {
    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function name() public pure returns (string memory) {
        return _name;
    }
}
