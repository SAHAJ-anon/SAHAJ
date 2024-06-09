/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://redstone.finance/
    Twitter:  https://twitter.com/redstone_defi
    Telegram: https://t.me/redstonefinance
    Discord: https://discord.com/invite/PVxBZKFr46


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
