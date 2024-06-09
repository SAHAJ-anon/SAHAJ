// SPDX-License-Identifier: MIT
/**                  __                 v1.1+
                    / _|                     
   __ _  __ _ _   _| |_                      
  / _` |/ _` | | | |  _|__              _    
 | (_| | (_| | |_| | |  _ \            | |   
  \__, |\__, |\__,_|_| |_) | __ _ _ __ | | __
   __/ | __/ |   / _ \  _ < / _` | '_ \| |/ /
  |___/ |___/   |  __/ |_) | (_| | | | |   < 
                 \___|____/ \__,_|_| |_|_|\_\
*/
pragma solidity ^0.8.25;

import "./TestLib.sol";
contract depositFacet {
    function deposit() public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.balances[msg.sender] += msg.value;
    }
}
