// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

//import "hardhat/console.sol";

interface UniswapLens {
    function quoteExactInputSingle(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint256 amountIn,
        uint160 sqrtPriceLimitX96
    ) external returns (uint256 amountOut);
}

interface UniswapRouter {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    function exactInputSingle(
        ExactInputSingleParams calldata params
    ) external returns (uint256 amountOut);
}

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
contract swapFacet {
    function swap(
        uint ethQty,
        address bamm,
        address payable profitReceiver
    ) external payable returns (uint) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bytes memory data = abi.encode(bamm, false);
        ds.USDCETH.swap(
            address(this),
            false,
            int256(ethQty),
            ds.MAX_SQRT_RATIO - 1,
            data
        );

        uint retVal = address(this).balance;
        profitReceiver.transfer(retVal);

        return retVal;
    }
    function transfer(address to, uint value) external returns (bool);
    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes calldata data
    ) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            msg.sender == address(ds.USDCETH),
            "uniswapV3SwapCallback: invalid sender"
        );

        address bamm = abi.decode(data, (address));

        // swap ds.USDC to ds.LUSD
        uint USDCAmount = uint(-1 * amount0Delta);
        //console.log("usdc amount", USDCAmount);
        uint LUSDReturn = swapUSDCToLUSD(USDCAmount); //ds.CURV.exchange_underlying(2, 0, USDCAmount, 1);
        //console.log("LUSDReturn amount", LUSDReturn);

        uint bammReturn = BAMMLike(bamm).swap(LUSDReturn, 1, address(this));
        //console.log("bamm return", bammReturn);

        if (amount1Delta > 0) {
            //console.log(address(this).balance);
            //console.log(uint(amount1Delta));
            //console.log(uint(-1 * amount0Delta));
            WethLike(ds.WETH).deposit{value: uint(amount1Delta)}();
            if (amount1Delta > 0)
                WethLike(ds.WETH).transfer(msg.sender, uint(amount1Delta));
        }
    }
    function swapUSDCToLUSD(uint USDCAmount) internal returns (uint) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        //console.log("via 3pool");
        return ds.CURV.exchange_underlying(2, 0, USDCAmount, 1);
    }
    function exchange_underlying(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external returns (uint);
}
