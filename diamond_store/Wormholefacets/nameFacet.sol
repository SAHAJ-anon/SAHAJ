/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/wormholecrypto
    // Twitter: https://twitter.com/wormholecrypto
    // Website: https://wormhole.com/
    // Medium:  https://wormholecrypto.medium.com/
    // Discord: https://discord.com/invite/xsT8qrHAvV
    // Github:  https://github.com/wormholecrypto
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
