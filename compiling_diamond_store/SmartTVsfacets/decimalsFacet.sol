// SPDX-License-Identifier: UNLICENSE

/*
    https://twitter.com/cb_doge/status/1766277816675692952
    https://t.me/SmartTVscoinerc20
*/

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
