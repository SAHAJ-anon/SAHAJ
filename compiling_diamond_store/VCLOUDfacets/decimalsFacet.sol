// SPDX-License-Identifier: MIT

/***

Website:   https://www.verismcloud.com
DApp:      https://app.verismcloud.com

Twitter:   https://twitter.com/verismcloud_erc
Telegram:  https://t.me/verismcloud_official_channel

***/

pragma solidity 0.8.20;
import "./TestLib.sol";
contract decimalsFacet is Ownable {
    using SafeMath for uint256;

    modifier lockSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwapBack = true;
        _;
        ds.inSwapBack = false;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
}
