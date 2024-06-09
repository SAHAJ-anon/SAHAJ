/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/plenafinance
    // Twitter: https://twitter.com/PlenaFinance
    // Website: https://www.plena.finance/
    // Discord: https://discord.com/invite/mSdtPkRfdr
    // Medium:  https://medium.com/@plenafinance
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
