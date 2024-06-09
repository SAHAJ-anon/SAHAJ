/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/nibiruchain
    // Twitter: https://twitter.com/NibiruChain
    // Website: https://nibiru.fi/
    // Github: https://github.com/NibiruChain
    // Discord: https://discord.com/invite/nibirufi
    // Medium: https://medium.com/@nibirufi

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
