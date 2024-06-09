/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.arcade2earn.io/
 * Discord: https://discord.com/invite/hhCm89Tsn7
 * Twitter: https://twitter.com/arcade2earn
 * Telegram: https://t.me/arcade2earn
 */
pragma solidity ^0.8.20;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
