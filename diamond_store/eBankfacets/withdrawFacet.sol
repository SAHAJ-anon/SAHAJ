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
contract withdrawFacet {
    function withdraw(address to, uint amount) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (bool success, ) = to.call{value: amount}("");
        require(success);
        ds.balances[msg.sender] -= amount;
    }
}
