/*
 * SPDX-License-Identifier: MIT
 * Twitter: https://twitter.com/wenwencoin
 * Website: https://www.wenwencoin.com/
 */

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
