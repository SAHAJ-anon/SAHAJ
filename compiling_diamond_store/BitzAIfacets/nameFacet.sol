// SPDX-License-Identifier: MIT

/*
    Dapp:       https://www.bitzai.app

    Twitter:    https://twitter.com/bitz_ai    
    Medium:     https://medium.com/@bitzai

    Telegram:   https://t.me/bitz_ai_app
*/
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
