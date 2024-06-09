/*
 * SPDX-License-Identifier: MIT
 * Website: https://burnt.com
 * X: https://twitter.com/burnt_
 * Discord: https://discord.gg/53GSh5Mwxm
 * Telegram: https://t.me/burnt_announcements
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
