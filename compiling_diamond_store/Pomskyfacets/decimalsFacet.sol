/**
            POMSKY - SHIBA`s BFF

            *   https://t.me/PomskyErc

            *   https://www.pomskyerc20.com/

            *   https://twitter.com/PomskyERC20

            *   https://medium.com/@pomskyerc/

            *   https://pomsky.gitbook.io/docs


/*
    * SPDX-License-Identifier: MIT

    
*/
pragma solidity 0.8.19;
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
