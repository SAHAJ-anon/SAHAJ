/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.gate.io/
 * Telegram: https://t.me/gateio_en
 * Twitter: https://twitter.com/gate_io
 * facebook: https://www.facebook.com/gateioglobal
 * Discord: https://airdrops.io/visit/kpn2/
 * Reddit: https://airdrops.io/visit/lpn2/
 */
pragma solidity ^0.8.22;

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
