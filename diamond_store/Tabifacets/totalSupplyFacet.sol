/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/Tabichain
    // Twitter: https://twitter.com/Tabichain
    // Website: https://www.tabichain.com/
    // Discord: https://discord.com/invite/Tabichain
    // Medium:  https://tabi-official.medium.com/
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
