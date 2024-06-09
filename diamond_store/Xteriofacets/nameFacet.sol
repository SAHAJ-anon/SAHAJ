/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/XterioGames
    // Twitter: https://twitter.com/XterioGames
    // Website: https://xter.io/
    // Discord: https://discord.com/invite/xter-io-991240141412769842
    // Medium:  https://medium.com/@XterioGames
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
