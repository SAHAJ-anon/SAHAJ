/**



https://www.dexidex.net/

*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "./TestLib.sol";
contract isExcludedFromFeesFacet is ERC20, Ownable {
    using SafeMath for uint256;

    function isExcludedFromFees(address account) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._isExcludedFromFees[account];
    }
}
