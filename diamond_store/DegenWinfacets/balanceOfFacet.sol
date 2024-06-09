/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/DegenWinCasino
 * Website: https://degenwin.com/
 * Reddit: https://www.reddit.com/r/DegenwinCasino
 * Telegram: https://t.me/+Hk2nLQTZQmJiOGM0
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
