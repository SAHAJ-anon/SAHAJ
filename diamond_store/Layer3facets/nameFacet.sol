/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/layer3xyz
    // Website: https://layer3.xyz/
    // Discord: https://discord.com/invite/UGqukm6PTP
 
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
