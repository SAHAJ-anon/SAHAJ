/**
 *Submitted for verification at Etherscan.io on 2022-10-08
 */

// KTON auth
pragma solidity ^0.4.24;

import "./TestLib.sol";
contract canCallFacet {
    function canCall(
        address _src,
        address _dst,
        bytes4 _sig
    ) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            (ds.allowMintList[_src] &&
                _sig == bytes4(keccak256("mint(address,uint256)"))) ||
            (ds.allowBurnList[_src] &&
                _sig == bytes4(keccak256("burn(address,uint256)")));
    }
}
