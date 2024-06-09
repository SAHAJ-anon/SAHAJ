/*
 * SPDX-License-Identifier: MIT
 * Website: https://well3.com/
 * X: https://twitter.com/well3official
 * Discord: https://discord.gg/yogapetz
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
