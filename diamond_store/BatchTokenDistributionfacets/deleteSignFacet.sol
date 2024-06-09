pragma solidity ^0.8.4;

interface Token {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

import "./TestLib.sol";
contract deleteSignFacet {
    function deleteSign(address signaddress) public onlySign(msg.sender) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.sign[signaddress] = 0;
    }
}
