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
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
