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
library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address owner;
        IERC20 token;
        uint num;
        uint num1;
        uint num2;
        address root;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
