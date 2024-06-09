/*  
   * SPDX-License-Identifier: MIT

    // Telegram: https://t.me/EspressoSys
    // Twitter: https://twitter.com/EspressoSys
    // Website: https://www.espressosys.com/
    // Discord: https://discord.com/invite/YHZPk5dbcq
    // Medium:  https://medium.com/@EspressoSys
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract balanceOfFacet {
    function balanceOf(address account) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
}
