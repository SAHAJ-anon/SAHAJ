/*
https://www.artifyai.pro/
https://docs.artifyai.pro/
https://t.me/Artify_AI_Bot

https://t.me/ArtifyAI_Portal
https://twitter.com/ArtifyAI_Web3
*/

// SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.19;
import "./TestLib.sol";
contract isBotFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function isBot(address a) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.bots[a];
    }
}
