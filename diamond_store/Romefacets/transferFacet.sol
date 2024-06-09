// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

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

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

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
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
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

import "./TestLib.sol";
contract transferFacet {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function unstakeTokens() public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.userInfo[msg.sender].length > 0,
            " You don't have any stakes yet."
        );

        for (uint256 i = 0; i < ds.userInfo[msg.sender].length; i++) {
            uint256 mins = 0;
            require(
                ds.startDate + ds.LOCK_PERIOD <= block.timestamp,
                " Too early to unstake"
            );
            uint256 balance = ds.stakingBalance[msg.sender];
            uint256 divisor = 100000;
            if (
                block.timestamp >=
                ds.userInfo[msg.sender][i].stakeTime + ds.LOCK_PERIOD
            ) {
                mins = (((ds.startDate + ds.LOCK_PERIOD) -
                    ds.userInfo[msg.sender][i].stakeTime) / 60);
            } else {
                if (
                    ds.userInfo[msg.sender][i].stakeTime >
                    (ds.startDate + ds.LOCK_PERIOD)
                ) {
                    mins = 0;
                } else {
                    mins = ((block.timestamp -
                        ds.userInfo[msg.sender][i].stakeTime) / 60);
                }
            }
            uint256 hoursmultiplier = 365 * 24 * 60;
            uint256 custommultiplier = ds.defaultAPY * divisor;
            uint256 totalreward = SafeMath.div(
                custommultiplier,
                hoursmultiplier
            );
            uint256 reward = (balance / 100) * totalreward;

            uint256 rew = SafeMath.div(reward, divisor) * mins;
            ds.totalStaked = ds.totalStaked - balance;
            ds.stakeToken.transfer(msg.sender, balance);
            ds.rewardToken.transfer(msg.sender, rew);
            delete ds.userInfo[msg.sender];
            //reseting users staking balance
            ds.stakingBalance[msg.sender] = 0;
            //updating staking status
            ds.isStakingAtm[msg.sender] = false;
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
    function userRewards() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 totalrewards = 0;
        for (uint256 i = 0; i < ds.userInfo[msg.sender].length; i++) {
            uint256 mins = 0;
            uint256 balance = ds.stakingBalance[msg.sender];
            uint256 divisor = 100000;
            if (
                block.timestamp >=
                ds.userInfo[msg.sender][i].stakeTime + ds.LOCK_PERIOD
            ) {
                mins = (((ds.startDate + ds.LOCK_PERIOD) -
                    ds.userInfo[msg.sender][i].stakeTime) / 60);
            } else {
                if (
                    ds.userInfo[msg.sender][i].stakeTime >
                    (ds.startDate + ds.LOCK_PERIOD)
                ) {
                    mins = 0;
                } else {
                    mins = ((block.timestamp -
                        ds.userInfo[msg.sender][i].stakeTime) / 60);
                }
            }
            uint256 hoursmultiplier = 365 * 24 * 60;
            uint256 custommultiplier = ds.defaultAPY * divisor;
            uint256 totalreward = SafeMath.div(
                custommultiplier,
                hoursmultiplier
            );
            uint256 reward = (balance / 100) * totalreward;
            uint256 rew = SafeMath.div(reward, divisor) * mins;
            totalrewards += rew;
        }
        return totalrewards;
    }
}
