/**

A Bitcoin L1 Money Market Protocol for BRC-20 & Atomical Token Standards, facilitating seamless Borrowing/Lending 🏛

https://ordibank.org/
https://twitter.com/Ordibank    
https://t.me/ordibank
https://discord.gg/ordibank
https://ordibank.gitbook.io/

**/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view virtual returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply;
    }
}
