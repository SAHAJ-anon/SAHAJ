/**
Website: Chainminer.io
Telegram: https://t.me/Chainminerio
Twitter: https://twitter.com/ChainMinerio
*/

//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
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
