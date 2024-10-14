/*

https://twitter.com/BillyM2k/status/1775200578953674886/photo/1

 TG: https://t.me/shibetoshicat

*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;
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
