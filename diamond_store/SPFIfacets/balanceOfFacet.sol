/*
 * SPDX-License-Identifier: MIT
 * Website: https://spin.fi/?utm_source=icodrops
 * Github: https://github.com/spin-fi/
 * Twitter: https://twitter.com/spin_fi
 * Telegram: https://t.me/spin_fi_chat
 * Medium: https://spin-fi.medium.com/
 * Discord: https://discord.gg/e3jUf3dDZu
 */
pragma solidity ^0.8.22;

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
