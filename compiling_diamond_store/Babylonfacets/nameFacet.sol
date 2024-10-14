// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._name;
    }
}
