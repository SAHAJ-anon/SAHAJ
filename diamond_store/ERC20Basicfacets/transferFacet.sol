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
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint tokens);
    function transfer(address receiver, uint numTokens) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(numTokens <= ds.balances[msg.sender]);
        ds.balances[msg.sender] = ds.balances[msg.sender] - numTokens;
        ds.balances[receiver] = ds.balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
}
