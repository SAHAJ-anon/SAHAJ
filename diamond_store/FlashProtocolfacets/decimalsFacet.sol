/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/flashprotocol
 * Twitter: https://twitter.com/flashprotocol
 * Website: https://flashprotocol.xyz/
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