/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/Imaginary_Ones
    // Twitter: https://twitter.com/Imaginary_Ones
    // Website: https://www.velar.co/
    // Discord: https://discord.com/invite/io-imaginary-ones
 
*/

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
