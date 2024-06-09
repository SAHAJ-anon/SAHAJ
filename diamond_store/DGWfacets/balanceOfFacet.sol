/*
 * SPDX-License-Identifier: MIT
 * Website: https://degenwin.com/
 * Twitter: https://twitter.com/DegenWinCasino
 * Telegram: https://t.me/+Hk2nLQTZQmJiOGM0
 * Reddit: https://www.reddit.com/r/DegenwinCasino
 */
pragma solidity ^0.8.21;

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
