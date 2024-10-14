// SPDX-License-Identifier: MIT

/*
    Web      : https://inteliai.org
    DApp     : https://loans.inteliai.org
    Staking  : https://stake.inteliai.org
    Leverage : https://leverage.inteliai.org
    Docs     : https://gitbook.inteliai.org

    Telegram : https://t.me/inteli_ai_tech_official
    Twitter  : https://x.com/Inteli_AI_Tech
*/

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
