// SPDX-License-Identifier: MIT

/*
    Website  : https://agath.org
    Apps     : https://app.agath.org
    Docs     : https://docs.agath.org

    Twitter  : https://twitter.com/AgathAIYield
    Telegram : https://t.me/AgathAI_Official    
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
