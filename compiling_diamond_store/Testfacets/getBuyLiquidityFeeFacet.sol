/*

Test Test Test

*/
// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.17;
import "./TestLib.sol";
contract getBuyLiquidityFeeFacet is ERC20, Ownable {
    using SafeMath for uint256;

    function getBuyLiquidityFee() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.buyLiquidityFee;
    }
}
