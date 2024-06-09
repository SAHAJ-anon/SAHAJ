pragma solidity ^0.8.0;

import "./TestLib.sol";
contract returnStringFacet {
    function returnString() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.a;
    }
}
