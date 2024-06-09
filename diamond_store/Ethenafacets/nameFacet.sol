/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/ethena_labs
    // Twitter: https://twitter.com/ethena_labs
    // Website: https://www.ethena.fi/
    // Discord: https://discord.com/invite/HVfuYyNm8S
 
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
