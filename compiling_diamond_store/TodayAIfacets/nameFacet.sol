/**

*/

/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/todaythegame
    // Website: https://side.xyz/today / https://www.todaythegame.com/
    // Discord: https://discord.com/invite/todaythegame
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
