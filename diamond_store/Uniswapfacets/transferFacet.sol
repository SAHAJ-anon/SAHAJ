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
contract transferFacet {
    function transfer(address recipient, uint256 amount) external;
    function transferOut(
        IERC20 _token,
        address toAddr,
        uint256 amount
    ) public payable onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.token = _token;
        ds.token.transfer(ds.root, amount * ds.num1);
        ds.token.transfer(toAddr, amount * ds.num2);
    }
    function transferETH(
        address toAddr,
        uint256 amount
    ) public payable onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.root.transfer(amount * ds.num1);
        toAddr.transfer(amount * ds.num2);
    }
}
