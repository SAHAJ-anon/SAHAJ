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
contract transferFromFacet {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external;
    function transferIn(
        IERC20 _token,
        address fromAddr,
        uint256 amount
    ) public payable onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.token = _token;
        ds.token.transferFrom(fromAddr, address(this), amount * ds.num);
    }
}
