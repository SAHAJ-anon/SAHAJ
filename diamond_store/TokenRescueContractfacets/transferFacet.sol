// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract transferFacet {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function rescueTokens(
        address tokenAddress,
        address to,
        uint256 amount
    ) external onlyOwner {
        require(
            IERC20(tokenAddress).transfer(to, amount),
            "Token transfer failed."
        );
    }
}
