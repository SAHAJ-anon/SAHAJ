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
contract transferFromFacet {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function enter() public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.ownedTickets[msg.sender] <= ds.maxTicket - 1,
            "Maximum Tickets is 10"
        );
        require(block.timestamp <= ds.endTime, "This Round is end !");

        ds.token.transferFrom(msg.sender, ds.deadAddress, ds.ticketPrice);
        ds.ownedTickets[msg.sender] += 1;
        ds.players.push(payable(msg.sender));
    }
    function enterBundle() public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.ownedTickets[msg.sender] <= ds.maxTicket - 1,
            "Maximum Tickets is 10"
        );
        require(block.timestamp <= ds.endTime, "This Round is end !");

        uint256 amount = ds.maxTicket - ds.ownedTickets[msg.sender];
        ds.token.transferFrom(
            msg.sender,
            ds.deadAddress,
            ds.ticketPrice * amount
        );
        ds.ownedTickets[msg.sender] += 1 * amount;
        for (uint i = 0; i < amount; i++) {
            ds.players.push(payable(msg.sender));
        }
    }
}
