pragma solidity ^0.8.0;

import "./TestLib.sol";
contract setStringFacet {
    function setString(string memory _a) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.a = _a;
    }
}
