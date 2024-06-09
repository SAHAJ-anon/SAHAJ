/**
 .----------------.  .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. |
| |      __      | || |  _______     | || |  _________   | || |  ____  ____  | |
| |     /  \     | || | |_   __ \    | || | |  _   _  |  | || | |_  _||_  _| | |
| |    / /\ \    | || |   | |__) |   | || | |_/ | | \_|  | || |   \ \  / /   | |
| |   / ____ \   | || |   |  __ /    | || |     | |      | || |    \ \/ /    | |
| | _/ /    \ \_ | || |  _| |  \ \_  | || |    _| |_     | || |    _|  |_    | |
| ||____|  |____|| || | |____| |___| | || |   |_____|    | || |   |______|   | |
| |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------' 

⚡️ $ARTY Listed On Uniswap 🦄
New era of gaming!⚡️
Artyfact Official Links🔗
Explore metaworld, play PAE games, exhibit and trade NFTs, make events, and much more!
⚡️Official Website
https://www.artyfact.game/
⚡️Official Twitter
https://twitter.com/artyfact_game
Official Telegram Group
https://t.me/artyfactgroup
⚡️Official Telegram Channel
https://t.me/artyfactnews
⚡️Official Discord
https://discord.com/invite/artyfact
⚡️Official Instagram
https://instagram.com/artyfact.game
⚡️Official Facebook
https://www.facebook.com/artyfactmetaverse
⚡️Official Medium
https://medium.com/@artyfact
⚡️Official Github:
https://github.com/artyfactmetaverse
⚡️Official Email:
office@artyfact.game
**/

// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.20;

interface IUniswapFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function swapExactTokensForETHSupportingFreelyOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct StoreData {
        address tokenMkt;
        uint8 buyFee;
        uint8 sellFee;
    }
    struct TestStorage {
        string _name;
        string _symbol;
        uint8 decimals;
        uint256 totalSupply;
        StoreData storeData;
        uint256 swapAmount;
        mapping(address => uint256) balanceOf;
        mapping(address => undefined) allowance;
        address pair;
        IUniswapV2Router02 _uniswapV2Router;
        bool swapping;
        bool tradingOpen;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
