/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/BsquaredNetwork
 * Website: https://buzz.bsquared.network/?utm_source=icodrops
 * Medium: https://medium.com/@bsquarednetwork
 * Discord: https://discord.com/invite/bsquarednetwork
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
