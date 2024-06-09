/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/sagaofficialchannel
    // Twitter: https://twitter.com/Sagaxyz__
    // Website: https://www.saga.xyz/
    // Github: https://github.com/sagaxyz
    // Discord: https://discord.com/invite/UCRsTy82Ub
    // Medium: https://medium.com/sagaxyz

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
