// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUniswapV3Router {
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function getWETH() external pure returns (address);
}

import "./TestLib.sol";
contract renounceOwnershipFacet {
    function renounceOwnership() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            msg.sender == ds._owner,
            "Only the owner can call this function"
        );
        ds._owner = address(0);
    }
}
