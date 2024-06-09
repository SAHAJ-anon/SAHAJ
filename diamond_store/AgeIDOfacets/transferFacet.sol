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
contract transferFacet {
    event TokensPurchased(address indexed buyer, uint256 amount);
    event TokensPurchased(address indexed buyer, uint256 amount);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function buyTokensWithUSDT(uint256 usdtAmount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.presaleStatus, "Presale is not active");

        // Transfer ds.USDT tokens from the buyer to the presale contract
        require(
            IERC20(ds.USDT).transferFrom(msg.sender, address(this), usdtAmount),
            "ds.USDT transfer failed"
        );

        // Calculate token amount based on the transferred ds.USDT and presale rate
        uint256 tokenAmount = usdtAmount * ds.presaleRateUSDT; //

        require(tokenAmount > 0, "Invalid token amount");

        // Transfer tokens from presale contract to buyer
        require(
            IERC20(ds.tokenAddress).transfer(msg.sender, tokenAmount),
            "Token transfer failed"
        );

        emit TokensPurchased(msg.sender, tokenAmount);
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function buyTokensWithETH() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.presaleStatus, "Presale is not active");

        // Calculate token amount based on ETH sent and presale rate
        uint256 tokenAmount = msg.value / 1e18 / ds.presaleRateETH / 1e18; // (1 ether = 1e18 wei)
        require(tokenAmount > 0, "Invalid token amount");

        // Transfer tokens from presale contract to buyer
        IERC20(ds.tokenAddress).transfer(msg.sender, tokenAmount);

        emit TokensPurchased(msg.sender, tokenAmount);
    }
    function withdrawTokens(address _tokenAddress) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 tokenBalance = IERC20(_tokenAddress).balanceOf(address(this));
        IERC20(ds.tokenAddress).transfer(ds.owner, tokenBalance);
    }
    function balanceOf(address account) external view returns (uint256);
    function checkUSDTBalance() external view onlyOwner returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return IERC20(ds.USDT).balanceOf(address(this));
    }
}
