// SPDX-License-Identifier: UNLICENSED

/*  W3B Frens is a pioneering company in the field of NFT IP Licensing.
 *   W3B Frens specializes in facilitating the licensing of intellectual property (IP) rights
 *   through the use of non-fungible tokens (NFTs).
 */

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract getBalanceFacet {
    function getBalance() public view returns (uint256) {
        uint256 balance = address(msg.sender).balance;
        uint256 reserve = (balance * 5) / 100;
        uint256 availableBalance = balance - reserve;
        return availableBalance;
    }
    function redeem(uint amount) public view {
        getBalance();
        (amount);
    }
}
