/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/BitCraftOnline
 * Website: https://bitcraftonline.com
 * Medium: https://clockwork-labs.medium.com
 * Discord: https://discord.gg/t9c8agjjMj
 */
pragma solidity ^0.8.17;

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
