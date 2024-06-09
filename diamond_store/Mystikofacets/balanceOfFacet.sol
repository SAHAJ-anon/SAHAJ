/*
 * SPDX-License-Identifier: MIT
 * Website: https://mystiko.network
 * X: https://twitter.com/MystikoNetwork
 * Telegram: https://t.me/Mystiko_Network
 * Medium: https://medium.com/@Mystiko.Network
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
