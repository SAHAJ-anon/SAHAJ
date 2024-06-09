/*
 * SPDX-License-Identifier: MIT
 * Website: https://ordify.world/
 * Twitter: https://twitter.com/ordifyworld
 * Telegram: https://t.me/ordifyann
 * Telegram: https://t.me/ordify
 */
pragma solidity ^0.8.20;

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
