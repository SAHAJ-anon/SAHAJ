/*********

    https://www.spindleai.finance
    https://app.spindleai.finance
    https://docs.spindleai.finance

    https://twitter.com/spindle_ai
    https://t.me/spindle_ai

*********/
// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;
import "./TestLib.sol";
contract isBotFacet is Ownable {
    using SafeMath for uint256;

    modifier lockSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwapBack = true;
        _;
        ds.inSwapBack = false;
    }

    function isBot(address a) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.bots[a];
    }
}
