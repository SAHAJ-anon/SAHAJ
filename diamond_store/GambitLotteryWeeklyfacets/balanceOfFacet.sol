// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
contract balanceOfFacet {
    function balanceOf(address account) external view returns (uint256);
    function pickWinner() public restricted {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.players.length > 0, "No ds.players in the lottery");
        require(ds.reward.balanceOf(address(this)) > 0, "Insufficient Balance");

        if (block.timestamp >= ds.endTime) {
            uint index = random() % ds.players.length;
            address payable winner = ds.players[index];
            ds.lotteryWinner = winner;
            ds.reward.transfer(winner, ds.reward.balanceOf(address(this)));

            // Reset ds.players array for the next lottery
            for (uint256 i = 0; i < ds.players.length; i++) {
                address ticketHolders = ds.players[i];
                ds.ownedTickets[ticketHolders] = 0;
            }

            ds.players = new address payable[](0);
            ds.round++;
            ds.endTime = block.timestamp + ds.countDownTicker;
        } else {
            require(false, "Countdown Condition Not Met");
        }
    }
    function random() private view returns (uint) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.prevrandao,
                        block.timestamp,
                        ds.players
                    )
                )
            );
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function transferStuckToken(
        address addy,
        uint256 amount
    ) public restricted {
        IERC20 stuckToken = IERC20(addy);

        stuckToken.transfer(msg.sender, amount);
    }
    function clearStuckETH() public restricted {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.manager.transfer(address(this).balance);
    }
    function getNativeTokenBalance() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.token.balanceOf(address(this));
    }
    function totalBurn() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.token.balanceOf(ds.deadAddress);
    }
}
