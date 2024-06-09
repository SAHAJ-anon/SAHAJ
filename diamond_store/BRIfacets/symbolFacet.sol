/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/BrightpoolX
 * Website: https://brightpool.finance/
 * Medium: https://medium.com/@Brightpool.finance
 * Discord: https://discord.com/invite/Up84GAStR2
 */
pragma solidity ^0.8.24;

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
