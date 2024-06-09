/*
 * SPDX-License-Identifier: MIT
 * Website:  https://ordify.world/
 * Telegram: https://t.me/ordify
 * Twitter:  https://twitter.com/ordifyworld
 */
pragma solidity ^0.8.22;

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
