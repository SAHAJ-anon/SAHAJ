/**
 */

// Where Browsing Becomes Rewarding !

// Telegram : https://t.me/atombrowserapp
// Twitter  : https://x.com/atombrowserapp
// Website  : https://atombrowser.app/
// Docs     : https://atom-browser.gitbook.io/atom-browser-whitepaper/
// Medium   : https://medium.com/@atombrowser

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function name() public pure returns (string memory) {
        return _name;
    }
}
