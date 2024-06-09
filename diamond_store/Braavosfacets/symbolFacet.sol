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
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
