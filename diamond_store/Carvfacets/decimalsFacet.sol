/*
 * SPDX-License-Identifier: MIT
 * Website: https://carv.io/home
 * X: https://twitter.com/carv_official
 * Telegram: https://t.me/carv_official_global
 * Youtube: https://www.youtube.com/channel/UCU9MzSdeEKLYUXnM6SfXFTQ
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
