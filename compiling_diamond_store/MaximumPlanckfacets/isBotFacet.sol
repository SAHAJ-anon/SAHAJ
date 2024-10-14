/**
https://t.me/MaximumPlanck
https://x.com/elonmusk/status/1772027984930611241?s=52&t=Fy14sqDz2upGEF0vQnjj0w

// SPDX-License-Identifier: UNLICENSE



*/
pragma solidity 0.8.23;
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
