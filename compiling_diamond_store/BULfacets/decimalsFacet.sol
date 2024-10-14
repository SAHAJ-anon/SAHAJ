// SPDX-License-Identifier: MIT

/** 

BUL ON ETHEREUM

**/

pragma solidity ^0.8.17;
import "./TestLib.sol";
contract decimalsFacet is Ownable {
    using SafeMath for uint256;

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
}
