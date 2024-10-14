// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;
    using Address for address;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwapAndLiquify = true;
        _;
        ds.inSwapAndLiquify = false;
    }

    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._name;
    }
}
