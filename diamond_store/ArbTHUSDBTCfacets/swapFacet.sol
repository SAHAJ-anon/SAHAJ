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
contract swapFacet {
    function swap(
        uint btcQty,
        address bamm,
        address profitReceiver
    ) external payable returns (uint) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        //console.log("doing swap");
        bytes memory data = abi.encode(bamm);
        // swap btc to eth
        ds.USDCBTC.swap(
            address(this),
            true,
            int256(btcQty),
            ds.MIN_SQRT_RATIO + 1,
            data
        );

        uint profit = ERC20Like(ds.WBTC).balanceOf(address(this));
        if (profit > 0) ERC20Like(ds.WBTC).transfer(profitReceiver, profit);

        return profit;
    }
    function balanceOf(address a) external view returns (uint);
    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes calldata data
    ) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (msg.sender == address(ds.USDCETH)) {
            //console.log("eth swap");
            //console.log(uint(-1 * amount0Delta));
            //console.log(uint(amount1Delta));
            // send weth
            //console.log(ERC20Like(ds.WETH).balanceOf(address(this)));
            ERC20Like(ds.WETH).transfer(msg.sender, uint(amount1Delta));
            //console.log("eth was sent");
            return;
        } else {
            //console.log("wbtc swap");
            //console.log(uint(amount0Delta));
            //console.log(uint(-1 * amount1Delta));
            require(
                msg.sender == address(ds.USDCBTC),
                "must be uniswap ds.WBTC reserve"
            );
        }

        address bamm = abi.decode(data, (address));

        // swap ETH to ds.USDC
        uint msgValue = address(this).balance;
        uint ethAmount = uint(-1 * amount1Delta) + msgValue;
        if (msgValue > 0) {
            //console.log("deposit auxilary eth");
            WethLike(ds.WETH).deposit{value: uint(ethAmount)}();
        }

        // do simple swap without callbacks
        //console.log("swap eth");
        (int returnedUSDC, ) = ds.USDCETH.swap(
            address(this),
            false,
            int256(ethAmount),
            ds.MAX_SQRT_RATIO - 1,
            bytes("")
        );

        uint USDCAmount = uint(-1 * returnedUSDC);
        //console.log("usdc amount", USDCAmount);
        //console.log("swap usdc to lusd");
        uint LUSDReturn = swapUSDCToLUSD(USDCAmount);
        //console.log("LUSDReturn amount", LUSDReturn);

        //console.log("swap with bamm");
        uint tbtcRetAmount = BAMMLike(bamm).swap(LUSDReturn, 1, address(this));

        //console.log("bamm return", tbtcRetAmount);

        //console.log("swap tbtc to wbtc");
        uint wbtcRetVal = ds.CURV_WBTC_TBTC.exchange(1, 0, tbtcRetAmount, 1);
        //console.log("wbtc returned from curve", wbtcRetVal, ERC20Like(ds.WBTC).balanceOf(address(this)));
        //console.log(uint(amount0Delta), uint(-1 * amount0Delta));

        //console.log("transfer btc back to uniswap");

        ERC20Like(ds.WBTC).transfer(msg.sender, uint(amount0Delta));
    }
    function transfer(address to, uint value) external returns (bool);
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
    function exchange(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external returns (uint);
}
