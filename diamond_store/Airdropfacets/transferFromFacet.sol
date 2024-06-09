// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract transferFromFacet {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function sendToken(
        IERC20 token,
        address[] calldata recipients,
        uint256[] calldata amounts
    ) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            recipients.length == amounts.length,
            "Recipients and amounts must match in length"
        );
        for (uint256 i = 0; i < recipients.length; i++) {
            require(
                token.transferFrom(ds.owner, recipients[i], amounts[i]),
                "Transfer failed"
            );
        }
    }
}
