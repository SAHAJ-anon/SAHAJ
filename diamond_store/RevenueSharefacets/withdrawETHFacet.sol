// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract withdrawETHFacet {
    function withdrawETH() external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        payable(ds.owner).transfer(address(this).balance);
    }
}
