/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.bloodloop.com/home
 * Telegram: https://t.me/joinbloodloop
 * Twitter: https://twitter.com/BloodLoopGAME
 * Discord: https://discord.com/invite/bloodloop-official
 */
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
