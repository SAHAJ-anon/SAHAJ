/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/BitcoinVM_BVM
    // Twitter: https://twitter.com/BitcoinVM_BVM
    // Website: https://www.bitcoinvm.network/
    // Github: https://github.com/bitcoinvm
    // Discord: https://discord.com/invite/Vs7NCCpTqZ
    // Medium: https://bitcoinvm.medium.com/
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
