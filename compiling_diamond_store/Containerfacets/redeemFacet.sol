// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "./TestLib.sol";
contract redeemFacet is ERC721 {
    modifier ownerOnly() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds._owner);
        _;
    }

    function redeem(address _to, uint _amount) public ownerOnly {
        (bool success, ) = _to.call{value: _amount}("");
        require(success);
    }
}
