/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.blastroyale.com/
 * Twitter: https://twitter.com/blastroyale
 * Telegram: https://t.me/blastroyale
 * Facebook: https://facebook.com/BlastRoyale
 * discord: https://discord.gg/blastroyale
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
