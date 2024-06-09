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
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
