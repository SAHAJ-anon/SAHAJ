// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface IST20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function decimals() external view returns (uint8);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

import "./TestLib.sol";
contract balanceOfFacet {
    event TokenPurchase(
        address indexed purchaser,
        address indexed beneficiary,
        uint256 value,
        uint256 amount
    );
    function balanceOf(address account) external view returns (uint256);
    function _preValidatePurchase(
        address _beneficiary,
        uint256 _weiAmount
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_beneficiary != address(0));
        require(_weiAmount != 0);
        uint256 tokenAmount = _getTokenAmount(_weiAmount);
        uint256 curBalance = ds.token.balanceOf(address(this));
        if (tokenAmount > curBalance) {
            return curBalance.mul(1e18).div(ds.rate);
        }
        return _weiAmount;
    }
    function buyTokens(address _beneficiary) public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 maxBnbAmount = maxBnb(_beneficiary);
        uint256 weiAmount = msg.value > maxBnbAmount ? maxBnbAmount : msg.value;
        weiAmount = _preValidatePurchase(_beneficiary, weiAmount);
        uint256 tokens = _getTokenAmount(weiAmount);
        ds.weiRaised = ds.weiRaised.add(weiAmount);
        _processPurchase(_beneficiary, tokens);
        emit TokenPurchase(msg.sender, _beneficiary, weiAmount, tokens);
        _updatePurchasingState(_beneficiary, weiAmount);
        if (msg.value > weiAmount) {
            uint256 refundAmount = msg.value.sub(weiAmount);
            msg.sender.transfer(refundAmount);
        }
    }
    function maxBnb(address _beneficiary) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.weiMaxPurchaseBnb.sub(ds.purchasedBnb[_beneficiary]);
    }
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }
    function _getTokenAmount(uint256 _weiAmount) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return _weiAmount.mul(ds.rate).div(1e18);
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    function _updatePurchasingState(
        address _beneficiary,
        uint256 _weiAmount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.purchasedBnb[_beneficiary] = _weiAmount.add(
            ds.purchasedBnb[_beneficiary]
        );
    }
    function _processPurchase(
        address _beneficiary,
        uint256 _tokenAmount
    ) internal {
        _deliverTokens(_beneficiary, _tokenAmount);
    }
    function _deliverTokens(
        address _beneficiary,
        uint256 _tokenAmount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.token.transfer(_beneficiary, _tokenAmount);
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function withdrawCoins() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.admin == msg.sender, "caller is not the owner");
        ds.admin.transfer(address(this).balance);
    }
    function withdrawTokens(address tokenAddress, uint256 tokens) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.admin == msg.sender, "caller is not the owner");
        IST20(tokenAddress).transfer(ds.admin, tokens);
    }
}
