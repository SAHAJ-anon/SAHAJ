/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/Entanglefi
    // Twitter: https://twitter.com/Entanglefi
    // Website: https://entangle.fi/
    // Github: https://github.com/Entanglefi
    // Discord: https://discord.com/invite/entangle
    // Medium: https://medium.com/Entanglefi/
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
