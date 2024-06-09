/*
 * SPDX-License-Identifier: MIT
 * Website: https://banksters.com
 * Whitepaper: https://docsend.com/view/vf5qxqjsnvec6ffp
 * Twitter: https://twitter.com/BankstersNFT
 * Telegram Group: https://t.me/BankstersNFT
 * Telegram Channel: https://t.me/BankstersNFTchannel
 * Discord: https://discord.gg/tEBVGuEE47
 * Medium: https://bankstersnft.medium.com
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
