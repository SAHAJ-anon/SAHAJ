/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/derivio_xyz
    // Twitter: https://twitter.com/derivio_xyz
    // Website: https://derivio.xyz/
    // Medium:  https://medium.com/@derivio_xyz
    // Discord: https://discord.com/invite/vHNRygkwcw
    // Github:  https://github.com/derivio_xyz
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
