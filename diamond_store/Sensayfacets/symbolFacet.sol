/*
 * SPDX-License-Identifier: MIT
 * Website:  https://www.snsy.ai/
 * Telegram: https://t.me/asksensay
 * Twitter:  https://twitter.com/asksensay
 * Linkedin: https://www.linkedin.com/company/asksensay
 */
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
