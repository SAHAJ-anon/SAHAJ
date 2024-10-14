// SPDX-License-Identifier: MIT

/** 

SwampDAO

We’re buying the Shrek Franchise music royalties

https://swampdao.com/
https://twitter.com/ShreksSwampDAO
https://swampdao.medium.com/
https://auctions.royaltyexchange.com/orderbook/asset-detail/5291
**/

pragma solidity 0.8.23;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function name() public pure returns (string memory) {
        return _name;
    }
}
