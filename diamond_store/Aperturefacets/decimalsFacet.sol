/*  
   * SPDX-License-Identifier: MIT
   
    //Telegram: https://t.me/ApertureFinance
    // Twitter: https://twitter.com/ApertureFinance
    // Website: https://www.aperture.finance/
    // Discord: https://discord.com/invite/MGHguks25G
    
 
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
