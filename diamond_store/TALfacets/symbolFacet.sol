/*
 * SPDX-License-Identifier: MIT
 * Website:  https://talentprotocol.com/
 * Telegram: https://t.me/talentprotocol
 * Discord:  https://discord.com/invite/talentprotocol
 * Twitter:  https://twitter.com/TalentProtocol
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
