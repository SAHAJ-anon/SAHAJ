/*
 * SPDX-License-Identifier: MIT
 * Website: https://myshell.ai
 * X: https://twitter.com/myshell_ai
 * Telegram: https://t.me/+6gQat3sxlewxNWVl
 * Discord: https://discord.com/invite/myshell
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
