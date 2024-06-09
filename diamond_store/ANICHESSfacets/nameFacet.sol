/*
 * SPDX-License-Identifier: MIT
 * Website: https://anichess.com/?utm_source=icodrops
 * Twitter: https://twitter.com/AnichessGame
 * Discord: https://discord.gg/anichess
 */
pragma solidity ^0.8.22;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
