/*
 * SPDX-License-Identifier: MIT
 * Website:  https://r-games.tech/
 * Telegram: https://t.me/RGamesOfficialChat
 * Twitter:  https://twitter.com/R_GamesOfficial
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
