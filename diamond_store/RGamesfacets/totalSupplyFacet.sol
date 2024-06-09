/*
 * SPDX-License-Identifier: UNLICENSED
 * Website: https://r-games.tech/
 * Twitter: https://twitter.com/R_GamesOfficial
 * Telegram: https://t.me/RGamesOfficialChat
 */
pragma solidity ^0.8.22;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
