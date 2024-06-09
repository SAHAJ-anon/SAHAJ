/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://www.welikethefox.io/
    Twitter:  https://twitter.com/FoxyLinea
    Medium:  https://welikethefox.medium.com/
    Telegram: https://t.me/WeLikeTheFox


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
