/**
 */

// SPDX-License-Identifier: MIT
/*

Grok PEPE Ai

🐸ɢʀᴏᴋ ᴘᴇᴘᴇ ᴀɪ ᴏꜰꜰɪᴄɪᴀʟ ʟɪɴᴋs

✅ᴛᴇʟᴇɢʀᴀᴍ:
https://t.me/pipeaientry

🌐ᴡᴇʙꜱɪᴛᴇ:
https://p1pe-ai.com/


**/

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
