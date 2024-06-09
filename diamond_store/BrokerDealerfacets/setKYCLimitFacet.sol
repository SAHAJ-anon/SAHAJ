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
contract setKYCLimitFacet {
    function setKYCLimit(uint256 tokenId, uint256 value) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.stakedAddr == msg.sender, "Not owner of AP token");
        ds._kycLimit[tokenId] = value;
    }
}
