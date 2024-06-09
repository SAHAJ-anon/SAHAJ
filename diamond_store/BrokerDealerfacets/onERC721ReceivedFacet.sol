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
contract onERC721ReceivedFacet {
    function onERC721Received(
        address,
        address from,
        uint256 tokenId,
        bytes calldata
    ) external returns (bytes4) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == address(ds.ap), "Not an AP token");
        require(ds.stakedTokenId == 0, "Cannot stake multiple AP tokens");
        require(tokenId != 0, "Cannot stake the Time Lord");

        ds.stakedAddr = from;
        ds.stakedTokenId = tokenId;

        return this.onERC721Received.selector;
    }
}
