/**

Twitter: https://twitter.com/WatcherGuru/status/1762896335957569864
Telegram: https://t.me/CoinbaseClassic

**/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
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
