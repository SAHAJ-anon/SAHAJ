// SPDX-License-Identifier: MIT
/*
Website : https://bvengine.network/
GitBook : https://bitcoin-virtual-engine.gitbook.io/bitcoin-virtual-engine-bve/

Twitter : https://twitter.com/BitcoinBVE
Telegram : https://t.me/BitcoinVirtualEngine

*/

pragma solidity ^0.8.9;
import "./TestLib.sol";
contract isTradingFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function isTrading() public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tradingOpen;
    }
}
