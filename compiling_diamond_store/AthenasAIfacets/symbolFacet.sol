// Website  : https://athenasai.io
// Telegram : https://t.me/athenasAI
// Whitepaper : https://docs.athenasai.io

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
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
