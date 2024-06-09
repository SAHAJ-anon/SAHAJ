pragma solidity ^0.4.23;

import "./TestLib.sol";
contract canCallFacet {
    function canCall(
        address _src,
        address,
        bytes4 _sig
    ) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            (ds.allowList[_src] &&
                _sig == bytes4(keccak256("mint(address,uint256)"))) ||
            (ds.allowList[_src] &&
                _sig == bytes4(keccak256("burn(address,uint256)")));
    }
}
