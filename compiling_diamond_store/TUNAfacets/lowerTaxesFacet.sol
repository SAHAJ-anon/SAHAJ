/**

    https://twitter.com/tunacoineth

**/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
import "./TestLib.sol";
contract lowerTaxesFacet is Context, Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function lowerTaxes() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_msgSender() == ds._operationsWallet);
        ds._finalBuyTax = 3;
        ds._finalSellTax = 3;
    }
}
