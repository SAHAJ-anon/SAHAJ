/**

*/

/*
 
 Telegram: https://t.me/+-TGx2LF68GQxNjcx
 SPDX-License-Identifier: Unlicensed

*/

pragma solidity ^0.8.19;
import "./TestLib.sol";
contract symbolFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._symbol;
    }
}
