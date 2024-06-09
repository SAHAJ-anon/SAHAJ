// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

interface IETF {
    function create(uint256, address) external payable;
    function redeem(uint256, address, uint256) external;
    function transferFrom(address, address, uint256) external returns (bool);
}

interface IAuthorizedParticipants {
    function safeTransferFrom(address, address, uint256) external;
}

interface IKYC {
    function getId(
        string memory,
        string memory
    ) external view returns (uint256);
    function getAddr(uint256) external view returns (address);
    function ownerOf(uint256) external view returns (address);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        IKYC kyc;
        IETF etf;
        IAuthorizedParticipants ap;
        mapping(uint256 => uint256) kycCreated;
        mapping(uint256 => uint256) kycRedeemed;
        mapping(uint256 => uint256) _kycLimit;
        uint256 stakedTokenId;
        address stakedAddr;
        bool redeemEnabled;
        bool createEnabled;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
