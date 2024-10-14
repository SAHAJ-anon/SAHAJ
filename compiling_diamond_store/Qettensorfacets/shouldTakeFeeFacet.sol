/*
Website: https://qettensor.xyz/
Telegram: https://t.me/Qettensor
Twitter: https://twitter.com/Qettensor
*/
pragma solidity ^0.8.17;
import "./TestLib.sol";
contract shouldTakeFeeFacet is Ownable {
    using SafeMath for uint256;

    modifier swapping() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function shouldTakeFee(address sender) internal view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return !ds.isFeeExempt[sender];
    }
}
