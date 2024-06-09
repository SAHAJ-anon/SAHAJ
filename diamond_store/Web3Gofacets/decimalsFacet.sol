/*
 * SPDX-License-Identifier: MIT
 * Website: https://web3go.xyz
 * X: https://twitter.com/Web3Go
 * Telegram: https://t.me/Web3GoCommunity
 * Youtube: https://www.youtube.com/channel/UCxUyipJO6O6LYNF-T7r-Kwg
 */

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
