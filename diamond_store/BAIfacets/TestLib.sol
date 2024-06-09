/**
 .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. |
| |   ______     | || |      __      | || |     _____    | |
| |  |_   _ \    | || |     /  \     | || |    |_   _|   | |
| |    | |_) |   | || |    / /\ \    | || |      | |     | |
| |    |  __'.   | || |   / ____ \   | || |      | |     | |
| |   _| |__) |  | || | _/ /    \ \_ | || |     _| |_    | |
| |  |_______/   | || ||____|  |____|| || |    |_____|   | |
| |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------' 

✉️ Telegram: https://t.me/BullAiERC20
❌ Twitter: https://twitter.com/BAI_ERC
🤖 BullBot: https://t.me/Official_BullBot
🌐 Website: https://bullai.site/
📔 Whitepaper: https://bullai.gitbook.io/bull-ai
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
