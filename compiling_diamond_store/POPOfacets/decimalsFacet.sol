// SPDX-License-Identifier: MIT
// https://t.me/popocoin_erc
// https://www.popocoin.club/
// https://twitter.com/popocoin_erc
pragma solidity 0.8.23;
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
