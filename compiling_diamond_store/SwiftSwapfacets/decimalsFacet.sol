/**
SwiftSwap - $SWIFT

SwiftSwap is the decentralized exchange (DEX) built to have the best possible prices on small trades

Website:  https://www.swiftswap.us
Telegram: https://t.me/swiftswap_erc
Twitter:  https://twitter.com/swiftswap_erc

**/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;
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
