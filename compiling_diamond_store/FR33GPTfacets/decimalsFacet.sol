// SPDX-License-Identifier: MIT

/**

   Website: https://fr33gpt.com
   Telegram: https://t.me/FR33GPTPortal
   X: https://x.com/@FR33GPT

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
