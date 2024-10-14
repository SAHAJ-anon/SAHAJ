/**

Website     : https://ai-mix.io/
Telegram    : https://t.me/aimixio
Twitter     : https://twitter.com/aimixio

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "./TestLib.sol";
contract symbolFacet is Ownable {
    using SafeMath for uint256;
    using Address for address;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwapAndLiquify = true;
        _;
        ds.inSwapAndLiquify = false;
    }

    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._symbol;
    }
}
