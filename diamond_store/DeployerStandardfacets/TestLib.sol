// SPDX-License-Identifier: MIT

/*

Utility contract to deploy standard tokens by Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/deployer

*/

pragma solidity 0.8.25;

interface IUtilFactory {
    function deploy(
        address owner,
        string calldata name,
        string calldata symbol,
        uint256 totalSupply,
        uint256 liquiditySupply,
        uint256 maxWallet,
        uint256 buyFee,
        uint256 sellFee,
        uint256 lockDays
    ) external payable;
    function deployerMode() external view returns (uint256);
    function getFactory(uint256 utility) external view returns (address);
}

interface IUtilPremium {
    function premium(address account) external view returns (bool);
}

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address utilPremium;
        address utilFactory;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
