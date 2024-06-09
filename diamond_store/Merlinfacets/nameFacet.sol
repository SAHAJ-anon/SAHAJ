/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/merlinchain
    // Twitter: https://twitter.com/MerlinLayer2
    // Website: https://merlinchain.io/
    // Discord: https://discord.com/invite/merlinchain
    // Medium:  https://merlinchain.medium.com/
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
