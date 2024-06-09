/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/gam3sgg_
 * Website: https://gam3s.gg/?utm_source=icodrops
 * Telegram: https://t.me/gam3sgg
 * Discord: https://discord.gg/gam3sgg
 * YouTube: https://www.youtube.com/@GAM3Sgg
 */
pragma solidity ^0.8.22;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
