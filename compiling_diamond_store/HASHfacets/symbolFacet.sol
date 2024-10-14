/*

 Telegram: https://t.me/HashAIEth
 Website: https://hashai.cc
 Twitter: https://twitter.com/hashai_eth
 Dapp: https://dapp.hashai.cc

*/

// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.20;
import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view virtual returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._symbol;
    }
}
