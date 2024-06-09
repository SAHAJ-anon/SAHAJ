/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/Parcl
    // Website: https://www.parcl.co/
    // Discord: https://discord.com/invite/parcl
 
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
