/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/mybraavos
    // Twitter: https://twitter.com/myBraavos
    // Website: https://braavos.app/
    // Discord: https://discord.com/invite/9Ks7V5DN9z
    // Medium:  https://medium.com/@braavos

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
