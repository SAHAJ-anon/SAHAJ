/**

MISSED $MAGA ? 
HERE IS YOUR SECOND CHANCE!
$MAGA 2.0 DIAMOND HANDS ONLY! 

https://t.me/MagaTwoCommunity
**/
// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;

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
