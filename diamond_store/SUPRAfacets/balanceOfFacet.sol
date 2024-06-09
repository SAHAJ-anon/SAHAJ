/*
 * SPDX-License-Identifier: MIT
 * Discord: https://discord.com/invite/supraoracles
 * Telegram: https://t.me/SupraOracles
 * Website: https://supra.com/
 */
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
