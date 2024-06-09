/*  
   * SPDX-License-Identifier: MIT 

    // Twitter: https://twitter.com/dappos_com
    // Website: https://dappos.com/
    // Telegram: https://t.me/DapposOfficial
    // Medium: https://medium.com/@dappos.com
    // Discord: https://discord.com/invite/sEtcYb9FgT
   

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
