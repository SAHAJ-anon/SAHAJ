/*  
   * SPDX-License-Identifier: MIT

     // Telegram: https://t.me/ponderone
    // Twitter: https://twitter.com/Ponder_One
    // Website: https://ponder.one/
    // Medium:  https://medium.com/@ponder-one
    // Discord: https://discord.com/invite/dYpdSckNnd
    // Github:  https://github.com/Ponder_One
*/

pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address FACTORY;
        address ROUTER;
        address WETH;
        uint256 tokenTotalSupply;
        string tokenName;
        string tokenSymbol;
        address xxnux;
        uint8 tokenDecimals;
        mapping(address => uint256) _balances;
        mapping(address => undefined) _allowances;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}