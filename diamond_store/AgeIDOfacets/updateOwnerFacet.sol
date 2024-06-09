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
contract updateOwnerFacet {
    function updateOwner(address _address) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.owner = _address;
    }
}
