/*
 * SPDX-License-Identifier: MIT
 * Website: https://carv.io/home
 * X: https://twitter.com/carv_official
 * Telegram: https://t.me/carv_official_global
 * Youtube: https://www.youtube.com/channel/UCU9MzSdeEKLYUXnM6SfXFTQ
 */

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
