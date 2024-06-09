/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/zkLendAnnouncements
    // Twitter: https://twitter.com/zkLend
    // Website: https://zklend.com/
    // Github: https://github.com/zkLend
    // Discord: https://discord.com/invite/3v7RhwtJ8S
    // Medium: https://medium.com/zklend
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
