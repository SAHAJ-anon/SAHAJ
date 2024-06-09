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
contract decimalsFacet {
    function decimals() external view returns (uint8);
}
