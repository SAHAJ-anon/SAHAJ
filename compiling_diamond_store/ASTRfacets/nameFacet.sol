/**
 *Submitted for verification at Etherscan.io on 2024-03-20
 */

// SPDX-License-Identifier: UNLICENSE

/*
      _       ______   _________  _______     
     / \    .' ____ \ |  _   _  ||_   __ \    
    / _ \   | (___ \_||_/ | | \_|  | |__) |   
   / ___ \   _.____`.     | |      |  __ /    
 _/ /   \ \_| \____) |   _| |_    _| |  \ \_  
|____| |____|\______.'  |_____|  |____| |___| 
                                              
*/

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
