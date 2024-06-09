/** 
 (               (                            (     
 )\ )            )\ )           )      (      )\ )  
(()/(         ) (()/(     )  ( /(      )\    (()/(  
 /(_)) (   ( /(  /(_)) ( /(  )\())  ((((_)(   /(_)) 
(_))_| )\  )\())(_))   )(_))((_)\    )\ _ )\ (_))   
| |_  ((_)((_)\ | |   ((_)_ | |(_)   (_)_\(_)|_ _|  
| __|/ _ \\ \ / | |__ / _` || '_ \ _  / _ \   | |   
|_|  \___//_\_\ |____|\__,_||_.__/(_)/_/ \_\ |___|  

Web: https://foxlabai.solutions

TG: https://t.me/FoxLabAi_Portal

Twitter (X): https://twitter.com/FoxLabAi

Launch 18TH 18:00 UTC

**/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );
    function approve(address delegate, uint numTokens) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }
}
