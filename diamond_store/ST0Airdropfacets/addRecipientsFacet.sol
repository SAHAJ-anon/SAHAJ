/*
  ______ ______ ______ ______ _____ _______ _______      ________            _____ 
 |  ____|  ____|  ____|  ____/ ____|__   __|_   _\ \    / /  ____|     /\   |_   _|
 | |__  | |__  | |__  | |__ | |       | |    | |  \ \  / /| |__       /  \    | |  
 |  __| |  __| |  __| |  __|| |       | |    | |   \ \/ / |  __|     / /\ \   | |  
 | |____| |    | |    | |___| |____   | |   _| |_   \  /  | |____   / ____ \ _| |_ 
 |______|_|    |_|    |______\_____|  |_|  |_____|   \/   |______| /_/    \_\_____|
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

import "./TestLib.sol";
contract addRecipientsFacet {
    function addRecipients(address[] calldata _recipients) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint i = 0; i < _recipients.length; i++) {
            if (!ds.recipientsClaimed[_recipients[i]]) {
                ds.recipients.push(_recipients[i]);
                ds.recipientsClaimed[_recipients[i]] = false;
            }
        }
    }
}
