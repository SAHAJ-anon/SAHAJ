/*
          ,.-·^*ª'` ·,               , ·. ,.-·~·.,   ‘             ,.  '                      _,.,  °        ,·'´¨;.  '                   
       .·´ ,·'´:¯'`·,  '\‘           /  ·'´,.-·-.,   `,'‚           /   ';\               ,.·'´  ,. ,  `;\ '      ;   ';:\           .·´¨';\   
     ,´  ,'\:::::::::\,.·\'         /  .'´\:::::::'\   '\ °       ,'   ,'::'\            .´   ;´:::::\`'´ \'\     ;     ';:'\      .'´     ;:'\  
    /   /:::\;·'´¯'`·;\:::\°    ,·'  ,'::::\:;:-·-:';  ';\‚      ,'    ;:::';'          /   ,'::\::::::\:::\:'    ;   ,  '·:;  .·´,.´';  ,'::;'  
   ;   ;:::;'          '\;:·´   ;.   ';:::;´       ,'  ,':'\‚     ';   ,':::;'          ;   ;:;:-·'~^ª*';\'´     ;   ;'`.    ¨,.·´::;'  ;:::;   
  ';   ;::/      ,·´¯';  °      ';   ;::;       ,'´ .'´\::';‚    ;  ,':::;' '          ;  ,.-·:*'´¨'`*´\::\ '    ;  ';::; \*´\:::::;  ,':::;‘   
  ';   '·;'   ,.·´,    ;'\        ';   ':;:   ,.·´,.·´::::\;'°   ,'  ,'::;'            ;   ;\::::::::::::'\;'    ';  ,'::;   \::\;:·';  ;:::; '   
  \'·.    `'´,.·:´';   ;::\'       \·,   `*´,.·'´::::::;·´      ;  ';_:,.-·´';\‘     ;  ;'_\_:;:: -·^*';\    ;  ';::;     '*´  ;',·':::;‘     
   '\::\¯::::::::';   ;::'; ‘      \\:¯::\:::::::;:·´         ',   _,.-·'´:\:\‘    ';    ,  ,. -·:*'´:\:'\°  \´¨\::;          \¨\::::;      
     `·:\:::;:·´';.·´\::;'          `\:::::\;::·'´  °           \¨:::::::::::\';     \`*´ ¯\:::::::::::\;' '  '\::\;            \:\;·'       
         ¯      \::::\;'‚              ¯                       '\;::_;:-·'´‘         \:::::\;::-·^*'´         '´¨               ¨'         
                  '\:·´'                 ‘                         '¨                    `*´¯                                              
                  www.golemcoin.tech
                  x.com/golemcointech
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        string name;
        string symbol;
        uint8 decimals;
        uint256 MAX_SUPPLY;
        uint256 MAX_BUY_PERCENTAGE;
        uint256 MAX_SELL_PERCENTAGE;
        uint256 TIME_LOCK_PERIOD;
        uint256 DUAL_ACTION_TIME_LOCK_PERIOD;
        uint256 FEE_PERCENTAGE;
        uint256 FEE_DECIMALS;
        mapping(address => uint256) balances;
        mapping(address => undefined) allowances;
        mapping(address => uint256) buyTimestamps;
        mapping(address => uint256) sellTimestamps;
        uint256 totalSupply;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
