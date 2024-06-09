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

import "./TestLib.sol";
contract createFacet {
    function create(
        string memory firstName,
        string memory lastName
    ) external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.createEnabled, "Share creation disabled");
        uint256 kycTokenId = ds.kyc.getId(firstName, lastName);

        require(
            ds.kyc.ownerOf(kycTokenId) == msg.sender &&
                ds.kyc.getAddr(kycTokenId) == msg.sender,
            "Invalid KYC Token"
        );

        uint256 tokensToCreate = msg.value * 10000;
        require(
            ds.kycCreated[kycTokenId] + tokensToCreate <= kycLimit(kycTokenId),
            "Cannot provide > 1ETH in liquidity"
        );

        ds.kycCreated[kycTokenId] += tokensToCreate;

        ds.etf.create{value: msg.value}(ds.stakedTokenId, msg.sender);
    }
    function getId(
        string memory,
        string memory
    ) external view returns (uint256);
    function redeem(
        string memory firstName,
        string memory lastName,
        uint256 etfAmount
    ) external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.redeemEnabled, "Share redeemption disabled");
        uint256 kycTokenId = ds.kyc.getId(firstName, lastName);

        require(
            ds.kyc.ownerOf(kycTokenId) == msg.sender &&
                ds.kyc.getAddr(kycTokenId) == msg.sender,
            "Invalid KYC Token"
        );

        require(
            ds.kycRedeemed[kycTokenId] + etfAmount <= kycLimit(kycTokenId),
            "Cannot remove > 1ETH in liquidity"
        );

        ds.kycRedeemed[kycTokenId] += etfAmount;

        ds.etf.transferFrom(msg.sender, address(this), etfAmount);
        ds.etf.redeem(ds.stakedTokenId, msg.sender, etfAmount);
    }
    function ownerOf(uint256) external view returns (address);
    function getAddr(uint256) external view returns (address);
    function kycLimit(uint256 tokenId) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return
            (ds._kycLimit[tokenId] > 0) ? ds._kycLimit[tokenId] : 10000 ether;
    }
    function transferFrom(address, address, uint256) external returns (bool);
}
