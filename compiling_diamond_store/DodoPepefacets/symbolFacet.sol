/**


// SPDX-License-Identifier: MIT
/*

              Telegram: https://t.me/Dodo_Pepe_Portal
             Website:   https://dodo-pepe.com/
           Twitter:     https://twitter.com/DodoPepeETH

*/
pragma solidity 0.8.22;
import "./TestLib.sol";
contract symbolFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }
}
