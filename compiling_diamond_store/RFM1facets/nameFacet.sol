// SPDX-License-Identifier: UNLICENSE

/*
    https://t.me/coinerc20
    https://readwrite.com/ai-powered-robot-maker-covariant-debuts-rfm-1-a-robot-language/
    https://twitter.com/pabbeel/status/1767237552455729657?s=20
*/

pragma solidity 0.8.23;
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
