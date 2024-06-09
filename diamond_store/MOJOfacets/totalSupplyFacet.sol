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
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
