/**

    Website: https://betafytoken.tech/
    Telegram: https://t.me/BetafyToken
    Twitter:  https://twitter.com/BetafyETH
    Bot: https://t.me/BetafyFaucetBot


**/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;
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
