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
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
