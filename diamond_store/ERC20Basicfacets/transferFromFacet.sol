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
contract transferFromFacet {
    event Transfer(address indexed from, address indexed to, uint tokens);
    function transferFrom(
        address owner,
        address buyer,
        uint numTokens
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(numTokens <= ds.balances[owner]);
        require(numTokens <= ds.allowed[owner][msg.sender]);

        ds.balances[owner] = ds.balances[owner] - numTokens;
        ds.allowed[owner][msg.sender] =
            ds.allowed[owner][msg.sender] -
            numTokens;
        ds.balances[buyer] = ds.balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
