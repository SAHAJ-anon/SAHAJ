// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.24;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract balanceOfFacet {
    event WithdrawnToken(address token, address to, uint256 amount);
    event WithdrawnETH(address to, uint256 amount);
    function balanceOf(address account) external view returns (uint256);
    function checkTokenBalance(
        address tokenAddress
    ) public view returns (uint256) {
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(address(this));
    }
    function withdrawToken(address tokenAddress) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        IERC20 token = IERC20(tokenAddress);
        uint256 balance = token.balanceOf(address(this));
        require(balance > 0, "No token balance");
        emit WithdrawnToken(tokenAddress, ds.owner, balance);
        token.transfer(ds.owner, balance);
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function withdrawETH() public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH balance");
        emit WithdrawnETH(ds.owner, balance);
        payable(ds.owner).transfer(balance);
    }
}
