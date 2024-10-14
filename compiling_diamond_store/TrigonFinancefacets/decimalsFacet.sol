// SPDX-License-Identifier: MIT

/*    
    Website  : https://www.trigon.finance
    DApp     : https://app.trigon.finance
    Twitter  : https://twitter.com/Trigon_Fi
    Telegram : https://t.me/trigon_fi
*/

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
