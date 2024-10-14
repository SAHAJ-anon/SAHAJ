// SPDX-License-Identifier: MIT

/*
Elevating moderation with artificial intelligence. MODAI is an all in one shield ensuring communities thrive safely.

https://modaieth.com 
https://twitter.com/modaierc
https://t.me/modaieth
https://t.me/tgmodai_bot
https://modai.gitbook.io/modai-documents
*/

pragma solidity 0.8.20;
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
