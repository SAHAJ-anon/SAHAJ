/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/+C3fpSjmPqzA5NTVh
    // Twitter: https://twitter.com/ether_fi
    // Website: https://www.ether.fi/
    // Github: https://github.com/etherfi
    // Discord: https://discord.com/invite/CuhQKGkEaF
    // Medium: https://medium.com/@etherfi
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
