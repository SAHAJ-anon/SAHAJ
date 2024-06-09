//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./TestLib.sol";
contract uploadVideoFacet {
    function uploadVideo(
        string memory _videoHash,
        string memory _title,
        string memory _description,
        string memory _location,
        string memory _category,
        string memory _thumbnailHash,
        string memory _date
    ) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        // Validating the video hash, title and author's address
        require(bytes(_videoHash).length > 0);
        require(bytes(_title).length > 0);
        require(msg.sender != address(0));

        // Incrementing the video count
        ds.videoCount++;
        // Adding the video to the contract
        ds.videos[ds.videoCount] = TestLib.Video(
            ds.videoCount,
            _videoHash,
            _title,
            _description,
            _location,
            _category,
            _thumbnailHash,
            _date,
            msg.sender
        );
        // Triggering the event
        emit VideoUploaded(
            ds.videoCount,
            _videoHash,
            _title,
            _description,
            _location,
            _category,
            _thumbnailHash,
            _date,
            msg.sender
        );
    }
}
