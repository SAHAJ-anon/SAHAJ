/*
 * SPDX-License-Identifier: MIT
 * Website: https://wormholenetwork.com/
 * Whitepaper: https://github.com/
 * Twitter: https://twitter.com/wormhole
 * Telegram: https://t.me/wormholecrypto
 * Discord Chat: https://discord.gg/xsT8qrHAvV
 * Medium: https://wormholecrypto.medium.com/
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
