/**
BE REEEEEEEEEEEEEEEADY!


TG: https://t.me/REEEEEEEEEEEEETH
Web: https://reeeeeeeeeeeee.com/
X: https://twitter.com/REEEEEEEEEEETH
*/
// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;
import "./TestLib.sol";
contract symbolFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }
}
