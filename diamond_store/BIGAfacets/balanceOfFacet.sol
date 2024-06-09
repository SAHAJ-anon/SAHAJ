/*
 * SPDX-License-Identifier: MIT
 * Website: https://bigarcade.org/
 * Discord: https://discord.com/invite/nGcGdS7tT3
 * Twitter: https://twitter.com/bigaarcade
 */
pragma solidity ^0.8.20;

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
