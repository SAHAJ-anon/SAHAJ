/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/zeusnetwork
    // Twitter: https://twitter.com/ZeusNetworkHQ
    // Website: https://zeusnetwork.xyz/
    // Discord: https://discord.com/invite/zeusnetwork
    // Medium:  https://medium.com/@zeus-network
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
