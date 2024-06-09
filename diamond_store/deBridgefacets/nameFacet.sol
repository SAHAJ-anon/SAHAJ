/*  
   * SPDX-License-Identifier: MIT 

    Website:  https://debridge.finance/
    Twitter:  https://twitter.com/deBridgeFinance
    Telegram: https://t.me/deBridge_finance
    Discord: https://discord.com/invite/debridge


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
