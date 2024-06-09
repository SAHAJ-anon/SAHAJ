/*
 * SPDX-License-Identifier: MIT
 * Website: https://snoozedoge.com/
 * Twitter: https://twitter.com/SnozAvax
 * Telegram: https://t.me/snoozedoge
 * Discord: https://discord.com/invite/WMzgZ8NZBU
 */
pragma solidity ^0.8.17;

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
