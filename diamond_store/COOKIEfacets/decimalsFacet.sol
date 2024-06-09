/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/cookie3Announcements
 * Twitter: https://twitter.com/cookie3_co
 * Website: https://cookie3.co/?utm_source=icodrops
 * Medium: https://medium.com/@cookie3
 * Linke: https://www.linkedin.com/company/cookie3
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
