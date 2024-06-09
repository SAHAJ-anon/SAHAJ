/*
 * SPDX-License-Identifier: MIT
 * Website: https://gam3s.gg/
 * Telegram: https://t.me/gam3sgg
 * Twitter: https://twitter.com/gam3sgg_
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
