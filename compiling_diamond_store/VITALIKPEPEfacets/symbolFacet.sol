/**
// SPDX-License-Identifier: UNLICENSE

https://vitalikpepe.com/
https://x.com/vitalikpepeeth
https://t.me/vitalikpepeportal

*/
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
