/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/SharpeLabs
    // Twitter: https://twitter.com/SharpeLabs
    // Website: https://sharpe.ai/
    // Discord: https://discord.com/invite/tFAvMTw6Hx
    // Medium:  https://sharpeai.medium.com/
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract nameFacet {
    function name() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenName;
    }
}
