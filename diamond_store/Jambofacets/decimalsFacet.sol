/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/JamboTechnology
    // Website: https://www.jambo.technology/
    // Discord: https://discord.com/invite/Vs7NCCpTqZ
    // Medium:   https://medium.com/jambo-technology
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
