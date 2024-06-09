/**
 
*/

/*  
   * SPDX-License-Identifier: MIT

      // Telegram: https://t.me/OmniFDN
    // Twitter: https://twitter.com/OmniFDN
    // Website: https://omni.network/
    // Medium:  https://medium.com/Omni_Network
    // Discord: https://discord.com/invite/bKNXmaX9VD
    // Github:  https://github.com/omni-network
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
