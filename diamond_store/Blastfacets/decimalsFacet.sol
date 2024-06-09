/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/Blast_L2
    // Website: https://blast.io/
    // Discord: https://discord.com/invite/blast-l2


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
