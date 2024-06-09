/*
 * SPDX-License-Identifier: MIT
 * Website:  https://fomobull.club/
 * Telegram: https://t.me/fomobullclub
 * Discord:  https://discord.com/invite/fomobullclub
 * Twitter:  https://twitter.com/fomobullclub
 */
pragma solidity ^0.8.23;

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
