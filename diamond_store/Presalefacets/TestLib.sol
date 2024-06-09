/**
 *Submitted for verification at testnet.bscscan.com on 2024-03-14
 */

//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.10;

interface IERC20 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external;

    function transfer(address to, uint256 value) external;

    function transferFrom(address from, address to, uint256 value) external;

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct user {
        uint256 Eth_balance;
        uint256 token_balance;
        uint256 claimed_token;
    }
    struct TestStorage {
        IERC20 SiriToken;
        address payable owner;
        uint256 tokenPerEth;
        uint256 softCap;
        uint256 endTime;
        uint256 startTime;
        uint256 soldToken;
        uint256 maxPurchase;
        uint256 minPurchase;
        uint256 totalSupply;
        uint256 userCount;
        uint256 amountRaisedInEth;
        address payable fundReceiver;
        uint256 divider;
        bool enableClaim;
        bool presaleStatus;
        mapping(address => undefined) users;
        mapping(uint256 => address) indexToUser;
        mapping(address => bool) isAlreadyMember;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
