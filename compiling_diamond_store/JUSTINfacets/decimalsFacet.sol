// SPDX-License-Identifier: MIT

/**
      - JUST IN -

https://justintoken.vip/
https://t.me/Justinportal
https://twitter.com/TokenJUSTIN
**/

pragma solidity 0.8.20;
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
