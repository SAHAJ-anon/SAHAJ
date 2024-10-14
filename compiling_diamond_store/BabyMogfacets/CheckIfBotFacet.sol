//Telegram: https://t.me/bmogcoin

//Twitter: https://twitter.com/babymogcoineth

//Website: https://babymog.vip

// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.23;
import "./TestLib.sol";
contract CheckIfBotFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function CheckIfBot(address a) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.bots[a];
    }
}
