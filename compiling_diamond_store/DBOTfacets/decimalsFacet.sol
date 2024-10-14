/*


$DBOT - DetectorAI Bot
Telegram: https://t.me/DetectorChanel 
Website: https://detectorbot.live/
Twitter: https://twitter.com/EthDetector

-----------------------------------------------------------------------

DBOT Features:
🔥LIQUIDITY BURN DETECTOR: https://t.me/LiquidityBurn
🎯SNIPE DETECTOR: https://t.me/SnipeDetector
💻PRE-APPROVAL DETECTOR: https://t.me/PreApproval



*/
//* SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.9;
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
