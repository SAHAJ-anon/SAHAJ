/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/nim_network
    // Website: https://nim.network/
    // Medium:  https://medium.com/@NIM_Network
    // Discord: https://discord.com/invite/nimnetwork

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
