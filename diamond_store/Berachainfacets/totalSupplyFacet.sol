/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/BerachainPortal
    // Twitter: https://twitter.com/berachain
    // Website: https://taiko.xyz/
    // Discord: https://discord.com/invite/berachain
    // Github:  https://github.com/berachain
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
