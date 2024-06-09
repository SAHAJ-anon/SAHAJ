// SPDX-License-Identifier: MIT
// Telegram: https://t.me/angrydogetoken

pragma solidity ^0.8.25;

import "./TestLib.sol";
contract allowanceFacet {
    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.z[owner][spender];
    }
}
