/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/robohero
 * Twitter:https://twitter.com/RoboHero_io
 * Website: https://robohero.io/
 * Discord: https://discord.com/invite/hAmY36DXdd
 * facebook: https://www.facebook.com/robohero.io
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
