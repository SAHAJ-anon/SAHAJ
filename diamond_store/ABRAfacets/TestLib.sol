/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.abra.com/?utm_source=icodrops
 * Facebook: https://www.facebook.com/AbraGlobal
 * Twitter: https://twitter.com/AbraGlobal
 * Reddit: https://www.reddit.com/user/AbraGlobal/
 * Linkedin: https://www.linkedin.com/company/abra/
 * Medium: https://www.abra.com/blog/
 * Youtube: https://www.youtube.com/channel/UCMb7-snlNp7ctSVlpqMbXFw?view_as=subscriber
 */
pragma solidity ^0.8.24;

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
