/*
 * SPDX-License-Identifier: MIT
 * Website: https://exv.io/
 * Telegram: https://t.me/exverse
 * Twitter: https://twitter.com/exverse_io
 */
pragma solidity ^0.8.22;

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
