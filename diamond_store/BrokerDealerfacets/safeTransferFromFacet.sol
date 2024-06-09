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
contract safeTransferFromFacet {
    function safeTransferFrom(address, address, uint256) external;
    function withdraw() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.stakedAddr == msg.sender, "Not owner of AP token");
        ds.stakedAddr = address(0);

        ds.ap.safeTransferFrom(address(this), msg.sender, ds.stakedTokenId);
        ds.stakedTokenId = 0;
    }
}
