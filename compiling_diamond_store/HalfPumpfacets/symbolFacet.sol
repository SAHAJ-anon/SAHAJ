/*
Website: https://halfpump.wtf/
Twitter: https://twitter.com/HalfPump_ERC/
TG: https://t.me/HalfPumpERC20/
*/

// SPDX-License-Identifier: UNLICENSE

pragma solidity 0.8.23;
import "./TestLib.sol";
contract symbolFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }
}
