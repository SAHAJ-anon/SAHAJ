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
contract getUnclaimedRecipientsFacet {
    function getUnclaimedRecipients() external view returns (address[] memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 count;
        for (uint256 i = 0; i < ds.recipients.length; i++) {
            if (!ds.recipientsClaimed[ds.recipients[i]]) {
                count += 1;
            }
        }

        address[] memory unclaimed = new address[](count);
        uint256 index;
        for (uint256 i = 0; i < ds.recipients.length; i++) {
            if (!ds.recipientsClaimed[ds.recipients[i]]) {
                unclaimed[index] = ds.recipients[i];
                index += 1;
            }
        }

        return unclaimed;
    }
}
