/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.holoworldai.com
 * X: https://twitter.com/HoloworldAI
 * Discord: https://discord.com/invite/uP3hGWQh8b
 * Medium: https://medium.com/@holoworldai
 */

pragma solidity ^0.8.23;

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
