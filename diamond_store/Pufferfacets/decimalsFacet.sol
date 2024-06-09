/*  
   * SPDX-License-Identifier: MIT


    // Telegram: https://t.me/puffer_fi
    // Twitter: https://twitter.com/puffer_finance
    // Website: https://www.puffer.fi/
    // Discord: https://discord.com/invite/pufferfi
    // Medium:  https://medium.com/@puffer.fi


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
