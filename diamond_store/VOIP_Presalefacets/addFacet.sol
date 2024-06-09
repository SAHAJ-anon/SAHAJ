// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

library SafeMath {
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IERC20 {
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

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

import "./TestLib.sol";
contract addFacet {
    event FundsRaised(uint256 amount);
    event FundsRaised(uint256 amount);
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
    function buyWithUsdt(uint256 _USDTAmount) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.currentRound < ds.roundLimits.length, "Presale has ended");
        require(
            ds.totalFundsRaised.add(_USDTAmount) <=
                ds.roundLimits[ds.currentRound],
            "Presale round limit reached"
        );

        uint256 tAmount = _USDTAmount.mul(ds.tokensPerUSDT);

        uint256 tokenAmount = tAmount.mul(10 ** 12);

        ds.USDT.transferFrom(msg.sender, ds.preSaleOwner, _USDTAmount);

        require(
            ds.token.balanceOf(address(this)) >= tokenAmount,
            "INSUFFICIENT_BALANCE_IN_CONTRACT"
        );

        bool sent = ds.token.transfer(msg.sender, tokenAmount);
        require(sent, "FAILED_TO_TRANSFER_TOKENS_TO_BUYER");

        // Update total funds raised
        ds.totalFundsRaised = ds.totalFundsRaised.add(_USDTAmount);

        emit FundsRaised(_USDTAmount); // Emit event

        if (ds.totalFundsRaised >= ds.roundLimits[ds.currentRound]) {
            ds.currentRound++;
            if (ds.currentRound < ds.roundLimits.length) {
                ds.tokensPerUSDT = ds.roundTokenPrices[ds.currentRound];
                ds.tokensPerETH = ds.roundTokenPricesEth[ds.currentRound];
            }
        }
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }
    function buyWithEth() public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.currentRound < ds.roundLimits.length, "Presale has ended");

        uint256 ethAmountToBuy = msg.value;
        uint256 tokenAmount = ethAmountToBuy.mul(ds.tokensPerETH);

        require(
            ds.token.balanceOf(address(this)) >= tokenAmount,
            "INSUFFICIENT_BALANCE_IN_CONTRACT"
        );

        // Calculate the equivalent ds.USDT value of the purchased tokens
        uint256 usdtVal = tokenAmount.div(ds.tokensPerUSDT);
        uint256 usdtValue = usdtVal.div(10 ** 12); // Keep only six decimal places

        payable(ds.preSaleOwner).transfer(msg.value);

        // Update total funds raised with only six decimal places
        ds.totalFundsRaised = ds.totalFundsRaised.add(usdtValue);

        // Emit event
        emit FundsRaised(usdtValue);

        // Transfer tokens to the buyer
        bool sent = ds.token.transfer(msg.sender, tokenAmount);
        require(sent, "FAILED_TO_TRANSFER_TOKENS_TO_BUYER");

        // Check if the current round limit is reached
        if (ds.totalFundsRaised >= ds.roundLimits[ds.currentRound]) {
            ds.currentRound++;
            if (ds.currentRound < ds.roundLimits.length) {
                ds.tokensPerUSDT = ds.roundTokenPrices[ds.currentRound];
                ds.tokensPerETH = ds.roundTokenPricesEth[ds.currentRound];
            }
        }
    }
    function balanceOf(address account) external view returns (uint256);
    function endPreSale() public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 contractTokenBalance = ds.token.balanceOf(address(this));
        ds.token.transfer(msg.sender, contractTokenBalance);
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function recoverTokens(address tokenToRecover) public onlyOwner {
        IERC20 tokenContract = IERC20(tokenToRecover);
        uint256 contractTokenBalance = tokenContract.balanceOf(address(this));
        require(contractTokenBalance > 0, "No tokens to recover");

        bool sent = tokenContract.transfer(msg.sender, contractTokenBalance);
        require(sent, "Failed to recover tokens");
    }
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}
