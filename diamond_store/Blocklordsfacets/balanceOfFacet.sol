/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.blocklords.com/?utm_source=icodrops
 * X: https://twitter.com/blocklords
 * Telegram: https://t.me/blocklordsgame
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
