/*
 * SPDX-License-Identifier: MIT
 * Discord: https://discord.com/invite/apeiron-doodaria
 * Twitter: https://twitter.com/ApeironNFT
 * Website: https://apeironnft.com/
 */
pragma solidity ^0.8.22;

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
