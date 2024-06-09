/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/Dop_org
    // Twitter: https://twitter.com/dop_org
    // Website: https://www.dopamineapp.com/
    // Discord: https://discord.com/invite/dopofficial
 
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
