/*


 - TWITTER: https://twitter.com/zerohedge/status/1777722130819330523

 - TG: https://t.me/GAUDI3ETH

 


*/

// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.23;
import "./TestLib.sol";
contract decimalsFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
}
