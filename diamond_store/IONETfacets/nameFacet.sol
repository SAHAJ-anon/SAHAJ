/**
 *Submitted for verification at Etherscan.io on 2024-03-22
 */

/*  
   * SPDX-License-Identifier: MIT
    ▫️Website: https://io.net/
    ▫️Twitter: https://twitter.com/ionet_official
    ▫️Telegram: https://t.me/io_net
    ▫️Discord: https://discord.gg/ionetofficial
*/
pragma solidity ^0.8.17;

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
