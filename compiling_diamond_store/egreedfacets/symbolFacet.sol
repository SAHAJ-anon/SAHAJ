/*

https://twitter.com/Jason/status/1774821337422602443

 TG: https://t.me/egreedeth

*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;
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
