/*

https://twitter.com/cb_doge/status/1766984439899230581

TG: https://t.me/veritaseth

*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;
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
