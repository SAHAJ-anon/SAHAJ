/*
 * SPDX-License-Identifier: MIT
 * Website: https://eesee.io
 * X: https://twitter.com/eesee_io
 * Tele: https://t.me/eesee_io
 * Discord: https://discord.gg/eesee
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
