/*
 * SPDX-License-Identifier: MIT
 * Website:  https://www.ten.xyz/
 * Discord:  https://discord.com/invite/yQfmKeNzNd
 * Telegram: https://t.me/tenprotocol
 * Twitter:  https://twitter.com/tenprotocol
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
