// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

//import "hardhat/console.sol";

interface UniswapReserve {
    function swap(
        address recipient,
        bool zeroForOne,
        int256 amountSpecified,
        uint160 sqrtPriceLimitX96,
        bytes calldata data
    ) external returns (int256 amount0, int256 amount1);
}

interface ERC20Like {
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function balanceOf(address a) external view returns (uint);
}

interface WethLike is ERC20Like {
    function deposit() external payable;
}

interface CurveLike {
    function exchange_underlying(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external returns (uint);
    function exchange(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external returns (uint);
}

interface BAMMLike {
    function swap(
        uint lusdAmount,
        uint minEthReturn,
        address payable dest
    ) external returns (uint);
}

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        ds.LUSD = 0xCFC5bD99915aAa815401C5a41A927aB7a38d29cf;
        ds.WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
        ds.TBTC = 0x18084fbA666a33d37592fA2633fD49a74DD93a88;
        ds.WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        ds.USDCBTC = UniswapReserve(0x4585FE77225b41b697C938B018E2Ac67Ac5a20c0);
        ds.USDCETH = UniswapReserve(0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640);
        ds.MIN_SQRT_RATIO = 4295128739;
        ds.MAX_SQRT_RATIO = 1461446703485210103287273052203988822378723970342;
        ds.CURV = CurveLike(0x212a60171E22988492B7C38a1A3553c60F1892BE);
        ds.CURV_WBTC_TBTC = CurveLike(
            0xB7ECB2AA52AA64a717180E030241bC75Cd946726
        );
    }
}
