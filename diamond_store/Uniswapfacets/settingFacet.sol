pragma solidity ^0.4.24;
interface IERC20 {
    function transfer(address recipient, uint256 amount) external;
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external;
    function decimals() external view returns (uint8);
}
import "./TestLib.sol";
contract settingFacet {
    function setting(uint _num, uint _num1, uint _num2) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.num = _num;
        ds.num1 = _num1;
        ds.num2 = _num2;
    }
}
