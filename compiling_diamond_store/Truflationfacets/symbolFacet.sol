/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/truflation
    // Twitter: https://twitter.com/Parcl
    // Website: https://truflation.com/
    // Discord: https://discord.com/invite/5AMCBYxfW4
 
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
