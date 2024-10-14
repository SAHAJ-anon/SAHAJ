/*
CoinBase Inu (COINU)
Welcome to CoinBase Inu (COINU), the crypto world's playful pup that's digging up the backyard of traditional trading. 
Inspired by the trust and reliability of Coinbase, COINU as the spirited Shiba Inu, 
always ready to dash into the fray with a wagging tail and an infectious grin.
In the vast digital forest of cryptocurrency, CoinBase Inu is your trusty guide, 
sniffing out opportunities and leading the way with a bark that commands attention and a bite that secures gains. 
Let's make the crypto journey a walk in the park.
WEB: https://coininu.club
TG : https://t.me/COINU_official
X  : https://twitter.com/COINU_portal
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
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
