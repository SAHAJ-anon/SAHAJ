/**
 *Submitted for verification at Etherscan.io on 2024-03-24
 */

// SPDX-License-Identifier: MIT

/**

Website: https://elumpcoin.com/
Telegram: https://t.me/ELUMPcoin
Twitter: https://twitter.com/ELUMPcoin

*/

pragma solidity 0.8.20;
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
