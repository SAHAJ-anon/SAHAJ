// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
// Telegram: https://t.me/AssemblyERC20Portal
// Twitter: https://twitter.com/AssemblyERC20

import "./TestLib.sol";
contract allowanceFacet {
    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
}
