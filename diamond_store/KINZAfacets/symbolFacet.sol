/*
 * SPDX-License-Identifier: MIT
 * Website:  https://kinza.finance/
 * Twitter: https://twitter.com/kinzafinance
 * Telegram: https://t.me/kinza_finance
 * Discord: https://discord.gg/JFXTEp8Nub
 * Medium: https://kinzafinance.medium.com/
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
