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
contract allowanceFacet {
    function allowance(
        address owner,
        address delegate
    ) public view returns (uint) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.allowed[owner][delegate];
    }
}
