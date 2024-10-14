// SPDX-License-Identifier: MIT

/**
Name: Caryn2D AI
Ticker: C2D

✅Telegram: https://t.me/CARYN2DCOIN

🕊Twitter: https://twitter.com/AIcaryn2d

🌐Website: https://caryn2d.xyz/

**/

pragma solidity 0.8.18;
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
