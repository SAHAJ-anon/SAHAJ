/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.privateai.com
 * X: https://twitter.com/privateAIcom
 * Discord: https://discord.gg/PrivateAI
 * Telegram: https://t.me/privateaicom
 */

pragma solidity ^0.8.23;

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
