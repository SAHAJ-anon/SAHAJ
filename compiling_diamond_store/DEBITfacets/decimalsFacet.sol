// SPDX-License-Identifier: MIT

/*
https://www.debit-hub.com
https://shop.debit-hub.com
https://docs.debit-hub.com

https://twitter.com/debithub
https://t.me/debithub_official
*/

pragma solidity 0.8.19;
import "./TestLib.sol";
contract decimalsFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
}
