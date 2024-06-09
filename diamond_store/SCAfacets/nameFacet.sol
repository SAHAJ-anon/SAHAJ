/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.scallop.io/
 * Whitepaper: https://docs.scallop.io/
 * Twitter: https://twitter.com/Scallop_io
 * Telegram Group: https://t.me/scallop_io
 * Discord Chat: https://airdrops.io/visit/0ll2/
 * Medium: https://medium.com/scallopio
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
