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
contract transferFacet {
    function transfer(address to, uint256 amount) external returns (bool);
    function claimTokens() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.recipientsClaimed[msg.sender] == false,
            "Tokens already claimed."
        );

        ds.recipientsClaimed[msg.sender] = true;
        require(
            ds.token.transfer(msg.sender, ds.airdropAmount),
            "Transfer failed."
        );
    }
    function withdrawTokens(address _to, uint256 _amount) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.token.transfer(_to, _amount), "Transfer failed.");
    }
}
