// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function getOwner() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address _owner,
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

interface IFactoryV2 {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address lpPair,
        uint
    );
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address lpPair);
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address lpPair);
}

interface IV2Pair {
    function factory() external view returns (address);
    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function sync() external;
}

interface IRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);
    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
}

interface IRouter02 is IRouter01 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

interface Initializer {
    function setLaunch(
        address _initialLpPair,
        uint32 _liqAddBlock,
        uint64 _liqAddStamp,
        uint8 dec
    ) external;
    function getConfig() external returns (address, address);
    function getInits(uint256 amount) external returns (uint256, uint256);
    function setLpPair(address pair, bool enabled) external;
    function checkUser(
        address from,
        address to,
        uint256 amt
    ) external returns (bool);
    function setProtections(bool _as, bool _ab) external;
    function removeSniper(address account) external;
}

import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function _approve(
        address sender,
        address spender,
        uint256 amount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: Zero Address");
        require(spender != address(0), "ERC20: Zero Address");

        ds._allowances[sender][spender] = amount;
        emit Approval(sender, spender, amount);
    }
    function approveContractContingency() external onlyOwner returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        _approve(address(this), address(ds.dexRouter), type(uint256).max);
        return true;
    }
    function setInitializer(address init) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(!ds.tradingEnabled);
        require(init != address(this), "Can't be self.");
        ds.initializer = Initializer(init);
        try ds.initializer.getConfig() returns (
            address router,
            address constructorLP
        ) {
            ds.dexRouter = IRouter02(router);
            ds.lpPair = constructorLP;
            ds.lpPairs[ds.lpPair] = true;
            _approve(ds._owner, address(ds.dexRouter), type(uint256).max);
            _approve(address(this), address(ds.dexRouter), type(uint256).max);
        } catch {
            revert();
        }
    }
    function getConfig() external returns (address, address);
}
