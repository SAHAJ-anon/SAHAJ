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
contract allowUnclogFacet is Context, Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function allowUnclog() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_msgSender() == ds._taxWallet);
        ds.transferDelayEnabled = false;
        ds.caSellLimit = false;
    }
}
