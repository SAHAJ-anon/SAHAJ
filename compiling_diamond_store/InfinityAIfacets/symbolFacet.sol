// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "./TestLib.sol";
contract symbolFacet {
    using SafeMath for uint256;
    using Address for address payable;

    function symbol() public pure returns (string memory) {
        return _symbol;
    }
}
