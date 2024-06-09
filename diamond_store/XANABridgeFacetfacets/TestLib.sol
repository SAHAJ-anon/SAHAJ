/**
 *Submitted for verification at BscScan.com on 2024-03-13
 */

/**
 *Submitted for verification at Etherscan.io on 2024-03-08
 */

/**
 *Submitted for verification at testnet.bscscan.com on 2024-03-07
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IWXETA {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    function burn(address from, uint256 amount) external returns (bool);
    function mint(address receiver, uint256 amount) external returns (bool);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct XETABRIDGESTORAGE {
        bool initialized;
        address wxeta;
        address owner;
        uint256 chainId;
        uint256 depositId;
        uint256 releaseId;
        uint256 minDeposit;
        uint256 maxDeposit;
        mapping(address => bool) authorized;
        mapping(uint256 => bool) chainSupported;
        mapping(address => uint256) amountReleased;
        mapping(address => uint256) amountDeposited;
    }
    struct TestStorage {
        bytes32 XETABRIDGENAMESPACE;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
