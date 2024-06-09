// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract setPresaleRateETHFacet {
    event PresaleRateChangedETH(uint256 newRate);
    function setPresaleRateETH(uint256 rate) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.presaleRateETH = rate;
        emit PresaleRateChangedETH(rate);
    }
}
