/**
Hotel Ai, a revolutionary crypto project at the intersection of hospitality and artificial intelligence.

Website: http://hotelai.tech/
Telegram: https://t.me/hotelaierc20
Twitter: https://x.com/hotelaierc

**/

// SPDX-License-Identifier: MIT
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
