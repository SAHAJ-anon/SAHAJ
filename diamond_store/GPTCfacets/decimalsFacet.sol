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
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}