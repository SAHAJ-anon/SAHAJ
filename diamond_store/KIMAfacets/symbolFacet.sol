/*
 * SPDX-License-Identifier: UNLICENSED
 * Telegram: https://t.me/kimanetwork
 * Twitter: https://twitter.com/KimaNetwork
 * Website: https://kima.finance/
 */
pragma solidity ^0.8.20;

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
