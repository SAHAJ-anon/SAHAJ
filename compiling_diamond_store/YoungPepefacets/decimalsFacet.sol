// SPDX-License-Identifier: MIT
/*

Boy's Club: Young Pepe


https://t.me/YoungPepeETH

https://twitter.com/YoungPepeETH

http://youngpepeeth.com/


*/
pragma solidity 0.8.20;
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
