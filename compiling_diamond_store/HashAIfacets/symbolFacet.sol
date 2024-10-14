/**

    Website: https://hash-ai.net/
    Telegram: https://t.me/HashAI_Portal
    Twitter:  https://twitter.com/HashAIOfficial
    Bot: @Hash_AiBot


**/

// SPDX-License-Identifier: MIT

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
