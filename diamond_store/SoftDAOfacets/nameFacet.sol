/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.thesoftdao.com
 * X: https://twitter.com/thesoftdao
 * Tele: https://t.me/theSoftDAO
 * Discord: https://discord.com/invite/thesoftdao
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
