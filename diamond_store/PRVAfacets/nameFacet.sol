/*
 * SPDX-License-Identifier: MIT
 * Telegram: https://t.me/Privasea_ai
 * Discord:  https://discord.com/invite/yRtQGvWkvG
 * Twitter:  https://twitter.com/Privasea_ai
 * Website:  https://www.privasea.ai/
 */
pragma solidity ^0.8.22;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
