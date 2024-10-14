/*
Website: https://nettensor.com/
Documentation: https://docs.nettensor.com/
Twitter: https://twitter.com/nettensor/
Telegram : https://t.me/nettensor/
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;
import "./TestLib.sol";
contract minFacet is ERC20 {
    using SafeMath for uint256;

    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return (a > b) ? b : a;
    }
}
