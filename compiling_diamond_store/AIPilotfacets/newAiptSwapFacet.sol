// SPDX-License-Identifier: MIT

/**
    Web     : https://aipilot.money
    App     : https://app.aipilot.money
    Doc     : https://docs.aipilot.money

    Twitter : https://twitter.com/aipilotreactor
    Telegram: https://t.me/aipilot_official

*/
pragma solidity 0.8.19;
import "./TestLib.sol";
contract newAiptSwapFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwapAndLiquify = true;
        _;
        ds.inSwapAndLiquify = false;
    }

    function newAiptSwap() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.minAiptSwap = 0;
    }
}
