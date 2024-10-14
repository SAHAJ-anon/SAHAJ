// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;
import "./TestLib.sol";
contract renounceOwnershipFacet is Context {
    modifier onlyOwner() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds._owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    function renounceOwnership() public virtual onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        emit OwnershipTransferred(ds._owner, address(0));
        ds._owner = address(0);
    }
}
