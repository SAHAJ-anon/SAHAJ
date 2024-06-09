/*
 * SPDX-License-Identifier: UNLICENSED
 * Telegram: https://t.me/blastoffzone
 * Twitter: https://twitter.com/blastozone
 * Website: https://blastoff.zone/
 */
pragma solidity ^0.8.20;

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
