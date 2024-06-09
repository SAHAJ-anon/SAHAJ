/*  
   * SPDX-License-Identifier: MIT 

    //Telegram: https://t.me/omnifdn
    // Twitter: https://twitter.com/OmniFDN
    // Website: https://omni.network/
    // Discord: https://discord.com/invite/bKNXmaX9VD


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
