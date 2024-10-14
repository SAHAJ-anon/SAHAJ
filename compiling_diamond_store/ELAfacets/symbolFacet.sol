/**
https://www.endlesslend.com/
https://app.endlesslend.com/
https://docs.endlesslend.com/

https://t.me/endlesslend_portal
https://twitter.com/Endless_Lend
 */

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;
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
