/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/VenomFoundationOfficial
    // Twitter: https://twitter.com/venomfoundation
    // Website: https://venom.foundation/
    // Discord: https://discord.com/invite/venomfoundation
    // Medium:  https://medium.com/@venom.foundation
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
