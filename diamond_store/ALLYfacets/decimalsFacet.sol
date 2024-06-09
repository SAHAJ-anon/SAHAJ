/*
 * SPDX-License-Identifier: MIT
 * Discord : https://discord.com/invite/2VqABVytBZ
 * Twitter : https://twitter.com/earnalliance
 * Website : https://www.earnalliance.com/
 * Facebook: https://www.facebook.com/earnalliance/
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
