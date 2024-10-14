// SPDX-License-Identifier: MIT

/*    
    Website : https://www.demeter.trading
    Staking : https://staking.demeter.trading
    Trading : https://dex.demeter.trading
    Docs    : https://docs.demeter.trading

    Telegram : https://t.me/demeter_fi
    Twitter  : https://twitter.com/Demeter_Fi
*/

pragma solidity 0.8.19;
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
