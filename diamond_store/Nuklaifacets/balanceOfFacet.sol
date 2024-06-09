/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.nukl.ai
 * X: https://twitter.com/NuklaiData
 * Telegram:  https://t.me/NuklaiOfficial
 * Discord: https://discord.gg/2VeHmckwAC
 */

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
