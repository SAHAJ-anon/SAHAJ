/**
// SPDX-License-Identifier: MIT
/*
          Telegram: https://t.me/SuperApeERC   
          Twitter: https://twitter.com/SuperApeERC
          Website: https://www.superape.info/   
*/
pragma solidity 0.8.24;
import "./TestLib.sol";
contract decimalsFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
}
