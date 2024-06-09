/*
 * SPDX-License-Identifier: MIT
 * Facebook:https://www.facebook.com/LegendsOfElysium/
 * Telegram: https://t.me/legendsofelysium_ann
 * Twitter: https://twitter.com/LegendsElysium
 * Website: https://legendsofelysium.io/?utm_source=icodrops
 * Discord: https://discord.com/invite/TnbyVTyYjv
 * Youtube: https://www.youtube.com/channel/UCn9UlLgiKG_dqOWVqYAENvQ
 * Medium: https://medium.com/@legendsofelysium
 */
pragma solidity ^0.8.23;

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
