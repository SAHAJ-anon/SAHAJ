/*
 * SPDX-License-Identifier: MIT
 * Website: https://arrland.com/
 * Twitter: https://twitter.com/ArrlandNFT
 * Telegram: https://t.me/ArrlandNFT
 * Discord: https://discord.gg/ec9zJB4d8M
 * Facebook: https://www.facebook.com/PiratesoftheArrland
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
